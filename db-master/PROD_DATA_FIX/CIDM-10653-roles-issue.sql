/*
Issue Description: CIDM-10653 The role of Sarah Edwards(sedwards@som.umaryland.edu) should be CJAMS_CW_PSYCHOTROPIC_PSYCHIARIST. In SailPoint it was changed to Pharmacist. It is now corrected in SailPoint but a datafix is need to do a clean up from CJAMS table.
Category/Module: User/ Roles
Root cause: This is a know sailpoint issue and data fix is needed to resolve the roles
Fix provided: Data fix has been done to update the roles in teammember table.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix:It was a known sailpoint integration issue and data fix is needed to resolve it.
*/


 -- Fixing the role issue
 -- Email='sedwards@som.umaryland.edu'
 -- securityusersid = '26fcf860-f88d-47fe-b92e-55c713ea8df9'
 -- principalid = '60374'

update teammember
set roletypekey = 'CWPSYPSYCH',
    updatedon = now(),
    updatedby = 'CIDM-10653'
where teammemberid='921f4963-a2cc-4b9d-9c1e-46a04a3dc62c'
and activeflag = 1;

update rolemapping
set roleid = 5991,
    updatedby = 'CIDM-10653',
    updatedon = now()
where principalid = '60374'
    and roleid = 5992
    and teamtypekey = 'CW'
    and activeflag = 1;