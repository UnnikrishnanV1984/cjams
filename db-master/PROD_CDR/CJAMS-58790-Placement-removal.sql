/*
Issue Description:CJAMS-58790 221030013608:There is a duplicate placement and unable to complete the new placement.
Category/Module: Placement 
Root cause: User entered duplicate placement and wants it to be removed
Fix provided: Data fix to delete the duplicate placemene for the case 221030013608
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
*/


update placement
set activeflag = 0,
    updatedby = 'CJAMS-58790',
    updatedon = now()
where placementid = 'e1c2e4b7-f839-46cb-bbf7-2a419b86eeaa'
and activeflag = 1;

update placementrevision
set activeflag = 0,
    updatedby = 'CJAMS-58790',
    updatedon = now()
where placementid = 'e1c2e4b7-f839-46cb-bbf7-2a419b86eeaa'
and activeflag = 1;

update routing
set activeflag = 0,
    updatedby = 'CJAMS-58790',
    updatedon = now()
where objectid = 'e1c2e4b7-f839-46cb-bbf7-2a419b86eeaa'
and activeflag =1;    