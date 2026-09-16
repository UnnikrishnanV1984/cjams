
/*
   Issue Description: CDM-33026
   Category/ Module  : Person
   Root cause:  User wants to remove the person the case
   Fix Provided: Did data fix to remove that person from that case 
*/


update cjams.actor 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-33026'
where actorid ='45b3c165-d3d7-40fb-a9a9-4bb790b68485';

update cjams.intakeservicerequestactor i 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-33026'
where intakeservicerequestactorid in('aa2da372-6617-4f34-9160-34fd863baf35') ;

update cjams.personrole p  
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-33026'
where personroleid  = 'c1e56b5d-b599-4596-8200-200856230839';

update cjams.actorrelationship a2 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-33026'
where actorrelationshipid in('3af0e466-cbcf-4c98-97aa-74fcc96bfc8c');
