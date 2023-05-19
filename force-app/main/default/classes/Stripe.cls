public without sharing class Stripe {
	@AuraEnabled(cacheable=false)
	public static String pay(String recordId) {
		Stripe__mdt stripe = fetchSettings();

		String endpoint = stripe.Proxy_URL__c;

		HttpRequest req = new HttpRequest();
		req.setEndpoint(endpoint + '/payment');
		req.setTimeout(20000);
		req.setMethod('POST');
		req.setHeader('origin', Url.getOrgDomainUrl().toExternalForm());
		req.setHeader('Content-Type', 'application/json');
		req.setHeader('fromapex', UserInfo.getUserId());

		JSONGenerator contentBody = JSON.createGenerator(true);

		contentBody.writeStartObject();
		contentBody.writeStringField(
			'todaysDate',
			String.valueOf(System.currentTimeMillis())
		);
		contentBody.writeStringField('key', stripe.Secret__c);
		contentBody.writeStringField('orgId', UserInfo.getOrganizationId());
		contentBody.writeStringField('recordId', recordId);
		contentBody.writeEndObject();

		String stringData = contentBody.getAsString();

		String encryptedString = encryptData(
			stripe.ENCRYPTION_KEY__c,
			stripe.IV__c,
			stringData
		);

		JSONGenerator content = JSON.createGenerator(true);

		content.writeStartObject();
		content.writeStringField('content', encryptedString);
		content.writeEndObject();

		req.setBody(content.getAsString());

		Http http = new Http();

		try {
			HTTPResponse res = Test.isRunningTest()
				? new HTTPResponse()
				: http.send(req);

			if (test.isRunningTest()) {
				res.setBody('{"status": "success"}');
			}

			if (res.getStatus() != '200') {
				AuraHandledException e = new AuraHandledException(res.getBody());
				e.setMessage(res.getBody());
				throw e;
			}
			system.debug(res);
			return res.getBody();
		} catch (Exception error) {
			system.debug('error');
			system.debug(error);

			return error.getMessage();
		}
	}

	private static Stripe__mdt fetchSettings() {
		return [
			SELECT Id, ENCRYPTION_KEY__c, IV__c, Proxy_URL__c, Secret__c
			FROM Stripe__mdt
			WHERE DeveloperName = 'Stripe'
		];
	}

	private static String encryptData(
		String inputKey,
		String inputIv,
		String inputString
	) {
		Blob key = Blob.valueOf(inputKey);
		Blob iv = Blob.valueOf(inputIv);

		Blob encryptedText = Crypto.encrypt(
			'AES128',
			key,
			iv,
			Blob.valueOf(inputString)
		);
		return EncodingUtil.base64Encode(encryptedText);
	}
}
