trigger ContactSendEmail on Contact (before insert) {
    List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
    for(Contact con : trigger.new){
        if(con.email != null){
            Messaging.SingleEmailMessage singleMail = new Messaging.SingleEmailMessage();
            singleMail.setTargetObjectId(con.Id);
            singleMail.setHtmlBody('Congratulations! A new contact has been added to our database.');
            singleMail.setSubject('New Update on your contact!');
            singleMail.setTreatTargetObjectAsRecipient(true);
            List<String> emailList = new List<String>();
            emailList.add(con.Email);
            singleMail.setToAddresses(emailList);
            emails.add(singleMail);
        }
    }
    // Send the emails
    if (!emails.isEmpty()) {
        Messaging.sendEmail(emails);
    }
}
