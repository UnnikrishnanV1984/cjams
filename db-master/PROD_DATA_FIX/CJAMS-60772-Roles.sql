/*
Issue Description: please do a datafix to fix the user roles julie.kreit@maryland.gov Remove CWSUPERVISOR and please make CWCASEWORKER as user's primary role
Category/Module: User/ Roles
Root cause: This is a know sailpoint issue and data fix is needed to resolve the roles
Fix provided: Data fix has been done to update the roles in teammember table.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix:It was a known sailpoint integration issue and data fix is needed to resolve it.
*/
update teammember
set roletypekey = 'CWCW',updatedby = 'CJAMS-60772',updatedon =  now()
where teammemberid in ('1b17107a-54ca-43e8-89c0-ca3e8de7af77') and activeflag=1;

update rolemapping
set roleid = '71',updatedby = 'CJAMS-60772',updatedon =  now()
where ID = '147018982' and activeflag=1;
