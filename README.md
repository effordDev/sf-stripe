# sf-stripe

<a href="https://githubsfdeploy.herokuapp.com?owner=effordDev&repo=sf-stripe">
  <img alt="Deploy to Salesforce"
       src="https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/deploy.png">
</a>

[screen-recorder-fri-may-19-2023-13-22-33.webm](https://github.com/effordDev/sf-stripe/assets/36901822/c415a093-2a3d-4089-abca-921a31453ef4)


Provides a jump start to implementing [Stripe](https://stripe.com/docs/api) into salesforce. Contains ```Strip__mdt``` object to store keys and configuration. An apex class ```Stripe.cls``` to make a callout to the node server and a Lightning Web Component ```stripe.lwc```that initates the callout to the Apex class.

##Getting Started

For the Node.js side [click here](https://github.com/effordDev/sf-node-stripe)

### Metadata

ENCRYPTION_KEY__c, IV__c should be 128 bits I used [allkeysgenerator](https://www.allkeysgenerator.com/Random/Security-Encryption-Key-Generator.aspx)

these should match what is stored as environment variables on the server.

Secret__c - plain string that will be hashed sha256 - hex

Create a ```Stripe__mdt``` record named 'Stripe' and populate the fields: 

ENCRYPTION_KEY__c
Initilization Vector - IV__c
Node server - Proxy_URL__c
Secret__c

---
Written with my cat🐱‍👤 [tokyo](https://www.tokyotech.us)
