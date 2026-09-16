/*
   Issue Description: CJAMS-69351 
   Category/ Module: Contact notes
   Root cause: While doing a data fix to remove PID# 4152575 Shellyann HENRY from CPS IR 261023811828 in all persons,Contacts and assessment tabs, intakeserviceid is used as unique id which deleted all the contact notes from the contacts tab.
   Fix Provided: Data fix was done by reactivating all the contact notes and removed PID# 4152575 Shellyann HENRY from Contacts.
   Code Fix: Not Needed
*/

update progressnote 
set activeflag=1, 
updatedon=now(),
updatedby='CJAMS-69351'
where intakeserviceid='3edcfd1a-499a-485f-87df-6a018bada27d' and updatedby ='CJAMS-68580' and activeflag=0;

update contactparticipant 
set intakeservicerequestactorid ='1723f520-a163-4a93-844e-2628eeb42813', updatedby ='CJAMS-69351', updatedon =now()
where progressnoteid ='97a1da31-50f2-4f65-b068-7d513a1e7042' and contactparticipantid ='739e50a3-ef91-4349-bfcc-8f55ba674135' and activeflag =1;
