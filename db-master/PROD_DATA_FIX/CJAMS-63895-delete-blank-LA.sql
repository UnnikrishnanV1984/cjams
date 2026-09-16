/*
Issue: CJAMS-63895 Blank Living Arrangement
Category/Module: Placement / Living Arrangement
Root cause: Record has been created successfully in "placement" table but somehow record was not inserted into "livingarrangement" table
            Data fix is needed to delete the blank Living arrangement record from placement table.
Fix provided:  Data fix has been done to delete the blank living arrangement from placement table.
Data/Code fix ticket#:  CJAMS-63895
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: We are unable to replicate this issue in stage-3 and we will monitor it for future reference.
*/

update placement 
set activeflag = 0,
    updatedby = 'CJAMS-63895',
    updatedon = now()
where placementid = '481743cd-8b7b-4984-8065-36a8f4a60e2c'
and activeflag = 1;

update placementrevision
set activeflag = 0,
    updatedby = 'CJAMS-63895',
    updatedon = now()
where placementid = '481743cd-8b7b-4984-8065-36a8f4a60e2c'
and activeflag = 1;

update routing
set activeflag = 0,
    updatedby = 'CJAMS-63895',
    updatedon = now()
where objectid = '481743cd-8b7b-4984-8065-36a8f4a60e2c'
and activeflag = 1;    