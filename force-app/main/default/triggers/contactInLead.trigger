trigger contactInLead on Lead (after insert) {
      contactInLead.createContact(Trigger.new);
}