/*
 * CDM-33009 - Assistance required for administrative screen out
 * Customer Email ID:carmen.phelps@maryland.gov
 * Customer Name:Carmen Phelps
 * Focus Area:Decision
 * 231020571621:Case screened in - in error - by after hours covering supervisor and placed on Program Manager's "tree". 
 * Assistance required with conducting an administrative override 
 * Screen URL: https://cw.cjams.mdthink.maryland.gov/#/pages/case-worker/cfbe47fa-cad0-4a95-b0c6-288bd2eb96e0/231020571621/dsds-action/cw-assignments
 * data fix to screen out the intake # I231010638085 and delete the linked IR case.
*/


UPDATE intakesnapshot
SET
updatedby = 'CDM-33009', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I231010638085' AND activeflag=1;

UPDATE intakedastaging
SET status = 'Closed',
updatedby = 'CDM-33009', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I231010638085' AND activeflag=1;

UPDATE intakeservicerequest  
SET   
    actiontype = null, intakeservicerequestclassid = '00000000-0000-0000-0000-000000000000', activeflag = 0, 
    updatedby = 'CDM-33009', updatedon = now() 
WHERE 
    servicerequestnumber = '231020571621'
AND intakeserviceid = 'cfbe47fa-cad0-4a95-b0c6-288bd2eb96e0' 
AND activeflag = 1;

UPDATE personprogramarea
SET activeflag = 0,
updatedon = now(),
updatedby = 'CDM-33009'
WHERE objectid = 'cfbe47fa-cad0-4a95-b0c6-288bd2eb96e0' AND activeflag =1;

update 
   caseassignment
set
  activeflag = 0,  
  updatedby = 'CDM-33009',
  updatedon = now() 
where objectid = 'cfbe47fa-cad0-4a95-b0c6-288bd2eb96e0';

update 
  routing
set
  activeflag = 0,  
  updatedby = 'CDM-33009',
  updatedon = now() 
where objectid = 'cfbe47fa-cad0-4a95-b0c6-288bd2eb96e0' and activeflag = 1;

