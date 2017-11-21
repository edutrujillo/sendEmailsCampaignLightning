public class sendCampaignEmails {
 @AuraEnabled
    public static String sendEmails(String id){
        try {
			System.debug('ID: '+id);
            CampaignMember[] cam =
                [select ContactId from CampaignMember where CampaignId = :id];
            
 			List<Id> lstids= new List<Id>();


            for(CampaignMember a : cam){
               	 EmailTemplate et=[Select id, HtmlValue from EmailTemplate where name = 'Webinar How to Invest your money' limit 1];
 				 Contact contact = [Select FirstName,Id from Contact where ID = :a.ContactId limit 1];
                
                 Messaging.Singleemailmessage mail = new Messaging.Singleemailmessage();
                 mail.setTargetObjectId(contact.Id);
                 
                 mail.setSenderDisplayName('Webinar: How to Invest your money');
                 String htmlBody = et.HtmlValue.replace('{!Customer_Event__c.Id}', 'Webinar: How to Invest your money');
                 htmlBody = htmlBody.replace('{!Contact.Id}', contact.Id);
                 htmlBody = htmlBody.replace('{!Contact.FirstName}', contact.FirstName);
                 mail.setHtmlBody(htmlBody);
                 mail.setSubject('Webinar: How to Invest your money');
                 Messaging.sendEmail(new Messaging.Singleemailmessage[] { mail });
            }
        } catch(DmlException e) {
            System.debug('An unexpected error has occurred: ' + e.getMessage());
        }

        return 'Updated!';
    }
}