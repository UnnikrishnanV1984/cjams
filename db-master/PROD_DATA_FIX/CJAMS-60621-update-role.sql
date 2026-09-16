/*
Issue Description: CJAMS-60621 requesting access to APS in CJAMS
Category/Module: User/ Roles
Root cause: This is a know sailpoint issue and data fix is needed to resolve the roles
Fix provided: Data fix has been done to update the roles in rolemapping to add CJAMS_CWCASEWORKER and teammember table to add CWCW as roletypekey
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix:It was a known sailpoint integration issue and data fix is needed to resolve it.
*/


 -- Fixing the role issue
 -- Email='ashley.nelson4@maryland.gov'
 -- securityusersid = '2ada3664-2263-4995-a368-164cf8df3ff0'
 -- principalid = '58980'

update teammember
set roletypekey = 'CWCW',
    updatedon = now(),
    updatedby = 'CJAMS-60621'
where teammemberid='c99af77a-f266-47ce-843c-f8f54e4ac9be'
and activeflag = 1;

update rolemapping
set roleid = 71,
    updatedby = 'CJAMS-60621',
    updatedon = now()
where principalid = '58980'
    and roleid = 135
    and teamtypekey = 'CW'
    and activeflag = 1;