/*
Issue Description: CJAMS-60469 The "add meeting" tab is is missing for stephen.williams@maryland.gov
Category/Module: User/ Roles
Root cause: This is a know sailpoint issue and data fix is needed to resolve the roles.
            stephen.williams@maryland.gov has has only CJAMS_CW_CASE_MGMT_SPECIALIST role as per the sailpoint. can we please do a datafix to remove CJAMS_CWSUPERVISOR role insert CJAMS_CW_CASE_MGMT_SPECIALIST into role mapping table.
            Deactivate role entries for CJAMS_CW_CASE_MGMT_SPECIALIST from userresource table
            Also update roletypekey as CWCMSP in team member table
Fix provided: Data fix has been done to update the roles in teammember and user resource tables.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix:It was a known sailpoint integration issue and data fix is needed to resolve it.
*/


 -- Fixing the role issue
 -- Email='stephen.williams@maryland.gov'
 -- securityusersid = '33e22dc0-2023-4e5d-a0aa-1ac8400bf929'
 -- principalid = '7729'

update teammember
set roletypekey = 'CWCMSP',
    updatedon = now(),
    updatedby = 'CJAMS-60469'
where teammemberid='9bd80102-bb77-4c9f-b6b6-4079fcea52ec'
and activeflag = 1;

update rolemapping
set roleid = 135,
    updatedby = 'CJAMS-60469',
    updatedon = now()
where principalid = '7729'
    and roleid = 71
    and activeflag = 1;