/*
Issue Description: CJAMS-60051 User unable to upload documents in CJAMS
Category/Module: User/ Roles
Root cause: This is a know sailpoint issue and data fix is needed to resolve the roles.
            darreisha.brock@maryland.gov has only CWINTAKEWORKER role as per the sailpoint. can we please do a datafix to remove CWSUPERVISOR role and insert CWINTAKEWORKER in rolemapping table.
Fix provided: Data fix has been done to update the roles in teammember table.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix:It was a known sailpoint integration issue and data fix is needed to resolve it.
*/


 -- Fixing the role issue
 -- Email='darreisha.brock@maryland.gov'
 -- securityusersid = '0dd103e2-2a10-409c-8338-3ec95f635781'
 -- principalid = '13348'

update teammember
set roletypekey = 'CWIW',
    updatedon = now(),
    updatedby = 'CJAMS-60051'
where teammemberid='fec014bd-3d67-4b93-9747-2660bc2d3d45'
and activeflag = 1;

update rolemapping
set roleid = 41,
    updatedby = 'CJAMS-60051',
    updatedon = now()
where principalid = '13348'
    and roleid = 71
    and teamtypekey = 'CW'
    and activeflag = 1;