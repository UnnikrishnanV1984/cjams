/*
   Issue Description: CDM-36188
   Category/ Module  :  Case Issue
   Root cause: Dummy service case was deleted
   Fix: Deleted service case, servicecasedisposition, routing and caseassginment
   Pull request# for code fix: 
   Reason why no related code fix: 
*/


update servicecase set activeflag = 0, updatedby = 'CDM-36188', updatedon = now()
where servicecaseid = '6a3e90db-05de-4710-9a4a-f66d4c6cbda9';

update servicecasedisposition set activeflag = 0, updatedon = now(), updatedby = 'CDM-36188' 
where servicecaseid = '6a3e90db-05de-4710-9a4a-f66d4c6cbda9' and servicecasedispositionid = '0db4e1c5-9104-4a06-ae0d-0c7297567cc7';

update routing set activeflag = 0, updatedon = now(), updatedby = 'CDM-36188' 
where routingid ='0d792f4b-1f89-4674-89aa-5ed2aaf2a123' and objectid = '6a3e90db-05de-4710-9a4a-f66d4c6cbda9';

update caseassignment set activeflag = 0, updatedon = now(), updatedby = 'CDM-36188' 
where caseassignmentid ='b309c711-d4fc-48a5-817c-2fb8037678f9' and objectid = '6a3e90db-05de-4710-9a4a-f66d4c6cbda9';