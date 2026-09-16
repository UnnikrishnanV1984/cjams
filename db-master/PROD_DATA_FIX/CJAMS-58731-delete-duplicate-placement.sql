/*
Issue Description:CJAMS-58731 2020030903985:I only put this living arrangement in once but it duplicated twice.
Category/Module: Placement 
Root cause: User entered duplicate placement and wants it to be removed
Fix provided: Data fix to delete the duplicate placemene for the case 2020030903985
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
*/


update placement
set activeflag = 0,
    updatedby = 'CJAMS-58731',
    updatedon = now()
where placementid = '71df406c-93b5-4c29-bafa-92b92c5742f3'
and activeflag = 1;

update placementrevision
set activeflag = 0,
    updatedby = 'CJAMS-58731',
    updatedon = now()
where placementid = '71df406c-93b5-4c29-bafa-92b92c5742f3'
and activeflag = 1;

update livingarrangement
set activeflag = 0,
    updatedby = 'CJAMS-58731',
    updatedon = now()
where placementid = '71df406c-93b5-4c29-bafa-92b92c5742f3'
and activeflag = 1;

update routing
set activeflag = 0,
    updatedby = 'CJAMS-58731',
    updatedon = now()
where objectid = '71df406c-93b5-4c29-bafa-92b92c5742f3'
and activeflag = 1;    







