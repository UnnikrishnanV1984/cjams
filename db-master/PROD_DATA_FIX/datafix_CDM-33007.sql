/*
 * CDM-33007 - Screen Out Assistance Required
 * Customer Email ID:carmen.phelps@maryland.gov
 * Customer Name:Carmen Phelps
 * Focus Area:Decision
 * Description - 231020608942:This case was screened in - in error - and placed on CPS Bureau Chief's tree by After Hours covering supervisor. 
 * Administrative Screen Out requested Screen URL: https://cw.cjams.mdthink.maryland.gov/#/pages/case-worker/3ca6c18d-a14b-4a21-9b28-a82ea643f4aa/231020608942/dsds-action/cw-assignments
 * data fix to screen out the intake # I231010679212 and delete the linked IR case.
*/


UPDATE intakesnapshot
SET
updatedby = 'CDM-33007', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I231010679212' AND activeflag=1;

UPDATE intakedastaging
SET status = 'Closed',
updatedby = 'CDM-33007', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I231010679212' AND activeflag=1;

UPDATE intakeservicerequest  
SET   
    actiontype = null, intakeservicerequestclassid = '00000000-0000-0000-0000-000000000000', activeflag = 0, 
    updatedby = 'CDM-33007', updatedon = now() 
WHERE 
    servicerequestnumber = '231020608942'
AND intakeserviceid = '3ca6c18d-a14b-4a21-9b28-a82ea643f4aa' 
AND activeflag = 1;

UPDATE personprogramarea
SET activeflag = 0,
updatedon = now(),
updatedby = 'CDM-33007'
WHERE objectid = '3ca6c18d-a14b-4a21-9b28-a82ea643f4aa' AND activeflag =1;

update 
   caseassignment
set
  activeflag = 0,  
  updatedby = 'CDM-33007',
  updatedon = now() 
where objectid = '3ca6c18d-a14b-4a21-9b28-a82ea643f4aa';

update 
  routing
set
  activeflag = 0,  
  updatedby = 'CDM-33007',
  updatedon = now() 
where objectid = '3ca6c18d-a14b-4a21-9b28-a82ea643f4aa' and activeflag = 1;