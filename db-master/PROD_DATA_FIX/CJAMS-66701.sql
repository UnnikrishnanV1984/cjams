/*
  Issue Description:CJAMS-66701-Unable to document in open case
   Category/ Module  :  Decision
   Root cause:  Requested to Remove Rejected Record from Decision Tab, Remove Open Assignment Record from Assignment Tab - so that user/Supervisor  can view Re open button to re submit to re open the case so that user can add the contact note
   Fix provided: Data fix is done to remove the rejected record in decision tab and remove the assignment record
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/



update servicecasedisposition
set activeflag=0,
updatedby='CJAMS-66701',updatedon=now()
where servicecasedispositionid='e9e2091a-2ff9-4ac9-8e42-b05b21a91589' and activeflag=1;

update caseassignment
set activeflag=0,
updatedby='CJAMS-66701',updatedon=now()
where caseassignmentid='96727851-6be3-4bab-a3b9-fddeeb134efb' and activeflag=1;