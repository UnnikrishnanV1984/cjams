
/*
   Issue Description: CDM-21516
   Category/ Module  : pERSON 
   Root cause: user error
   Pull request# for code fix: 5930
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/

 --- checked Actorrelationship as well  

UPDATE cjams.intakeservicerequestactor  
SET 
   personid = '586b612e-3581-42ed-9309-cbe11cd93f8e' , 
                updatedby = 'CDM-21516',
                updatedon = now() 
   where intakeserviceid ='3b74e089-4a56-43e5-a3af-879bcc65a804'
   and personid ='8725466f-0040-45e0-9614-9529535f56a1'; 
   
  
   
UPDATE cjams.actor  
 SET 
   personid = '586b612e-3581-42ed-9309-cbe11cd93f8e' , 
                updatedby = 'CDM-21516',
                updatedon = now() 
   where 
   actorid in ('d4e778c1-85d1-4c94-b20f-678fede7c5ff');
   
  
  UPDATE cjams.personprogramarea  
 SET 
   personid = '586b612e-3581-42ed-9309-cbe11cd93f8e' , 
                updatedby = 'CDM-21516',
                updatedon = now() 
 where personid ='8725466f-0040-45e0-9614-9529535f56a1'
and objectid ='3b74e089-4a56-43e5-a3af-879bcc65a804';



update cjams.personrole  set personid ='586b612e-3581-42ed-9309-cbe11cd93f8e',
                updatedby = 'CDM-21516',
                updatedon = now()
 where personid ='8725466f-0040-45e0-9614-9529535f56a1' and intakeserviceid  ='3b74e089-4a56-43e5-a3af-879bcc65a804';

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "5",
      "clientid": "200888389",
      "childname": "Emily Bennett"
    },
    {
      "age": "9",
      "clientid": "200567069",
      "childname": "ivy bennett"
    }
    ]')

where assessmentid = '3cc8b1be-4556-4134-87bc-d15f21533826' and submissionid ='6194fe62da1fda001a2c0135'
	and activeflag = 1 ;



update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "5",
      "clientid": "200888389",
      "childname": "Emily Bennett"
    },
    {
      "age": "9",
      "clientid": "200567069",
      "childname": "ivy bennett"
    }
    ]')

where assessmentid = 'f73245bc-0a71-4cc8-9e59-2a018d963460' and submissionid ='61b7f7c5876546001ab8d48c'
	and activeflag = 1 ; 
