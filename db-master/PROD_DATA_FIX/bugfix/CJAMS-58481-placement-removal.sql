/*
Issue Description: CJAMS-58481: Need data fix to delete two void placement records 
Category/Module: Placement 
Root cause: User has created two void placement records by error and need data fix to remove them.
Fix provided: Data fix has been done to delete the duplicate void placement records
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
*/

update placement
set activeflag = 0,
    updatedby = 'CJAMS-58481',
    updatedon = now()
where placementid in ('529f297e-e0e3-4c0c-9422-11a1cc18fd7a','300d3326-d3c1-481c-a760-81b083725eea')
and activeflag =1;

update placementrevision
set activeflag = 0,
    updatedby = 'CJAMS-58481',
    updatedon = now()
where placementid in ('529f297e-e0e3-4c0c-9422-11a1cc18fd7a','300d3326-d3c1-481c-a760-81b083725eea')
and activeflag =1;

update rolemapping 
set roleid = 71,
    updatedby = 'CJAMS-58481',
    updatedon = now()
where principalid='46424'
and activeflag = 1;

update teammemberassignment
set teammemberid = '166119b1-2fc8-4ce1-b0b8-d1db689aa9c8',
    updatedby = 'CJAMS-58481',
    updatedon = now()
where securityusersid = '04246415-42aa-4279-b37c-91525d96578d'
and activeflag=1;