/*
   Issue Description: CDM-38039
   Category/ Module  : Delete client
   Root cause: User added the client DEREK OMAR NEWTON Jr (CJAMS PID#:1303842) to the case 241021929391. Please delete this client from this case and remove PA for CPS for 241021929391.
   Pull request# for code fix: na
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update cjams.actor 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-38039'
where actorid ='97d34476-8e59-49b2-84d4-d1a6a8ac91ca';

update cjams.intakeservicerequestactor i 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-38039'
where intakeservicerequestactorid = 'cbc47b31-d118-46a4-a883-0dfeae566937';

update cjams.personrole p  
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-38039'
where personroleid  = 'd567c579-bd21-476d-b54e-bc6b575c982f';

update cjams.actorrelationship a2 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-38039'
where intakeservicerequestactorid = 'cbc47b31-d118-46a4-a883-0dfeae566937';


update cjams.personprogramarea set activeflag =0, updatedon = now(),
updatedby = 'CDM-38039'
where personprogramid ='76a3083e-d96b-41a5-a394-e69775ba9bec';