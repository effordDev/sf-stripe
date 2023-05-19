@isTest
public with sharing class StripeTest {
    
    @isTest
    private static void payTest() {

        Contact c = new Contact();
            c.LastName = 'Tokyo';
        insert c;

        Stripe.pay(c.Id);
    }
}