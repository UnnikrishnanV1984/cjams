/*
Issue Description: CJAMS-63255
Category/Module: Errpr with linked hospitalization and living arrangement
Root cause: Data fix to remove the review ER Medical Living Arrangement and keep the Person Hospitalization record and 
remove the link with the ER Medical Living Arrangement
Fix provided:  Data fix to remove the review ER Medical Living Arrangement and keep the Person Hospitalization record
and remove the link with the ER Medical Living Arrangement
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix: data fix 
*/

UPDATE
    cjams.placement
SET
    activeflag = 0,
    updatedby = 'CJAMS-63255',
    updatedon = now()
WHERE
    placementid = '868e7aaa-b2c2-4665-b996-06d8640163be'
    and activeflag = 1;

UPDATE
    cjams.placementrevision
SET
    activeflag = 0,
    updatedby = 'CJAMS-63255',
    updatedon = now()
WHERE
    placementid = '868e7aaa-b2c2-4665-b996-06d8640163be'
    and activeflag = 1;

UPDATE
    cjams.livingarrangement
SET
    activeflag = 0,
    updatedby = 'CJAMS-63255',
    updatedon = now()
WHERE
    placementid = '868e7aaa-b2c2-4665-b996-06d8640163be'
    and activeflag = 1;

UPDATE
    cjams.routing
SET
    activeflag = 0,
    updatedby = 'CJAMS-63255',
    updatedon = now()
where
    objectid = '868e7aaa-b2c2-4665-b996-06d8640163be'
    and activeflag = 1;

update  personhospitalization 
set updatedby= 'CJAMS-63255' ,  
     updatedon=now(),  
     activeflag = 2
where hospitalizationid = 'ccf928f3-399e-4bfe-92e3-97f62722a9dc' ;


update  personhospitalization_history 
set updatedby= 'CJAMS-63255' , 
    updatedon=now(),
     activeflag = 2
where hospitalizationid = 'ccf928f3-399e-4bfe-92e3-97f62722a9dc' 
 and personhospitalizationhistoryid = '295e90db-bfb0-46a3-8d49-6f38d4e59cd9';