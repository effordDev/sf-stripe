import { api, LightningElement } from "lwc";
import pay from "@salesforce/apex/Stripe.pay";
// import { loadStyle, loadScript } from 'lightning/platformResourceLoader';

// import stripeSDK from '@salesforce/resourceUrl/stripeSDK'

export default class Stripe extends LightningElement {
	@api recordId;

	async handlePay() {
		try {
			console.log("trying payment...");
			const result = await pay({
				recordId: this.recordId
			});
			console.log(result);
			const data = JSON.parse(result);
			console.log(data);

			if (data?.url) {
				window.location.href = data.url;
			}
		} catch (error) {
			console.log(error);
		}
	}
}
