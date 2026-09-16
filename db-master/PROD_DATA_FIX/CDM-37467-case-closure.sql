-- CDM-37467 - Case Closure
/*
-- Issue Description: 
   Dashboard:User is unable to access the ADD button when trying to close out the service case of 
   Shaniah Dennis case #3308057 

-- Case ID: 3308057

-- Category/ Module: Assignments
-- Root cause: User is unable to access the ADD button when trying to close out the service case of 
   Shaniah Dennis case #330805
-- Fix Provided: Promoted a datafix to soft delete record in servicedispositioncase table
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select *from servicecasedisposition
where servicecasedispositionid='40ae8b5c-e4de-49d5-ae23-f5001f03c4a6'
and activeflag=1;



update servicecasedisposition
set activeflag=0,
    updatedby = 'CDM-37467',
    updatedon = now()
where servicecasedispositionid = '40ae8b5c-e4de-49d5-ae23-f5001f03c4a6'
and activeflag=1;


select * from routing
where objectid = '40ae8b5c-e4de-49d5-ae23-f5001f03c4a6'
and activeflag = 1;

update routing 
set activeflag=0,
    updatedby = 'CDM-37467',
    updatedon = now()
where objectid = '40ae8b5c-e4de-49d5-ae23-f5001f03c4a6'
and activeflag=1;