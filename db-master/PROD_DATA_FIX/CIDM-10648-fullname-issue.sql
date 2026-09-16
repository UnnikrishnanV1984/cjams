/*
Issue Description: CIDM-10648 Null Null' in Psychiatrist dropdown list.
Category/Module: User/ Roles
Root cause: The user 'Gloria Reeves' was created in Sailpoint without any name and the same reflected in the CJAMS application. We can do a data fix is needed to correct the list by replacing null null with Gloria Reeves.
Fix provided: Data fix has been done to update the full name in userprofile table.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Full name was not entered in the sailpoint and data fix should resolve it.
*/

update userprofile
set fullName = 'Gloria Reeves',
    updatedby = 'CIDM-10648',
    updatedon = now()
where securityusersid = '961d6739-9ed2-4230-8baa-9dd6a7f7572f'
and activeflag = 1;