/*
   Issue Description: CDM-33147
   Category/ Module  :Contact notes
   Root cause: ::user requested to change the person in the contact 
   Fix Provided;  Did data fix to update the correct person in the given contact note 
*/
update cjams.contactparticipant set intakeservicerequestactorid ='4e63d4e6-78da-447f-9cd9-fcd48296cac0', updatedby ='CDM-33147', updatedon = now()

where contactparticipantid ='a27293b1-9160-4304-acee-992e7eb83ed9';