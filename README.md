# sf-stripe

[Demo](https://github.com/effordDev/sf-node-stripe/assets/36901822/04e024cb-cf3e-4538-9b93-aabfef469398)

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
Written with my cat🐱‍👤 [tokyo](www.tokyotech.us)