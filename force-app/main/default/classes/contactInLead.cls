public with sharing class contactInLead {
    public static void createContact(List<Lead> leadList) {

        List<Contact> conList = new List<Contact>();
        for(Lead l : leadList){
            Contact con = new Contact();
            con.LastName = l.LastName;
            con.FirstName = l.FirstName;
            con.Email = l.Email;
            con.Phone = l.Phone;
            
            conList.add(con);
        }
        insert conList;
    }
}
