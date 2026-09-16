/*
Issue Description:CJAMS-67680
Category/Module:Placement 
Root cause: Root cause: User requested to remove end date as they could not be able to delete end dates they can only create.
Fix provided: DB queries to update the records in personprogramarea table 
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: 
*/


update personprogramarea
set enddate = null ,
updatedby='CJAMS-67680',updatedon=now()
where personprogramid ='fa6c9522-ea51-4749-9d31-0e4b777688f4' and activeflag=1;