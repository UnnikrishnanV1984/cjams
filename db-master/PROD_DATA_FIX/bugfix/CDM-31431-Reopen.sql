
/*
   Issue Description: CDM-31431
   Category/ Module  : Dispostion
   Root cause: role issue for the user 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/

--Removed Dispostion Records
update cjams.servicecasedisposition set activeflag =0, updatedby ='CDM-31431', updatedon = now()
where servicecasedispositionid in ('b8eaf29c-ea24-4c02-809d-1976026f079a', 'e717bf3f-679d-4cd2-b9b2-5fe7d424668a');

--case assignment 
update cjams.caseassignment set enddate = null, updatedby='CDM-31431', updatedon = now()
where caseassignmentid ='33d69653-0ed2-4c6d-b2a8-7af1d6f65dd6';

---updated correct role --vivian.mayo@maryland.gov
update teammember set roletypekey ='CWSP', updatedby ='CDM-31345', updatedon = now()
where teammemberid ='38f59e3c-6916-40ce-899f-a706dbe71f03' and teamid ='6629c2a6-9d4d-4d3f-b6c2-0d842f161cc6';