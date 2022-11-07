//Write a trigger to check some validations while booking a room.

public class BookingHandler {
    public void onBeforeInsert(List<Booking__c> newBookingList ){
        
        Set<Id> roomIds = new Set<Id>();  // to store room Ids of new bookings
        Set<Id> customerIds = new Set<Id>();  // to store customer Ids of new bookings
        List<Date> startDateList = new List<Date>();
        for(Booking__c booking : newBookingList){
            if(booking.room__c != Null){
                roomIds.add(booking.room__c);
            }
            else if(booking.Customer__c != Null){
                customerIds.add(booking.Customer__c);
            }
        }
        List<Room__c> roomList = [SELECT Id, Name, Check_In_Check_Out_Time__c, Maintenance_Mode__c,
                                  (SELECT Id, Amount_Paid__c, Check_in_Status__c, Check_in_Time__c, Check_out_Time__c, Start_Date__c, 
                                   End_Date__c FROM Bookings__r WHERE Id IN : newBookingList)
                                  FROM Room__c 
                                  WHERE Id IN : roomIds ];
    }
    
}