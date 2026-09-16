/*
   Issue Description: CDM-38436 Duplicate Person We have a duplicate person on a case. Case number 202102905679 has 2 Jade Lee persons.
                      CJAMS PID 200312277 is the correct Person for Jade Lee.CJAMS PID 200921837 is the incorrect Person and all entries within the case that contain this person ID should be transfers to the correct Person ID
   Category/ Module  : Delete Person from case
   Root cause: User wants to remove the duplicate person from all the areas where he is mapped (PID 2009721837) 
   Fix Provided :Data fix has been promoted to delete duplicate from persons card, contacts, assessements, payments, Program assignments etc.
   Pull request# for code fix:  N/A
   Reason why no related code fix: N/A
   Status of the code fix if already submitted and expected prod fix date: N/A
   Backup before update/ delete: N/A
*/


update actor 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-38436'
where actorid = '3080763a-c99c-4ea7-9b05-1afc7a9e19d6';



update intakeservicerequestactor 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-38436'
where intakeservicerequestactorid = 'bade202a-d586-4d93-8c5c-2714b0fbdabb';


update personrole 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-38436'
where personroleid = '332f4032-e109-4b45-bcc6-8f6d07860ee2';


update cjams.actorrelationship 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-38436'
where actorrelationshipid = '6e79cd34-6071-425b-8772-ca4f0453862c';

update personroletype
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-38436'
where personroleid = '332f4032-e109-4b45-bcc6-8f6d07860ee2';
