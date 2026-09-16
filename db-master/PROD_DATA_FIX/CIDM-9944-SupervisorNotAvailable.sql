
/*
Issue: In the approval inbox the supervisor name is not available
Root Cause: The getroutingusers() db function, while listing supervisors, checks if each of them has a particular roletypekey in the table teammember. User crystal.stewart@montgomerycountymd.gov had the wrong roletypekey.
Fix Provided: Datafix to change the roletypekey from FNSFS to CWSP to make sure the user is listed among other supervisors.
Data/Code fix ticket#: CIDM-9944
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Incorrect value in database
*/

--Updating teammember
update teammember
set roletypekey = 'CWSP', updatedby = 'CIDM-9944', updatedon = now()
where teammemberid = 'a0000ccd-2c65-4551-9934-0c00bcb3633f' and activeflag = 1;