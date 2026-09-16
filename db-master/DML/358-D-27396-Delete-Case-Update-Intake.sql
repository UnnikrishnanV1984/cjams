UPDATE intakeservicerequest  
SET   
    actiontype = null, intakeservicerequestclassid = '00000000-0000-0000-0000-000000000000', activeflag = 0, 
    updatedby = 'admin-D-27396', updatedon = now() 
WHERE 
    servicerequestnumber = '2020065016547'
AND intakeserviceid = 'cc7a48b4-dc1d-4321-ac2b-013749c871e5' 
AND activeflag = 1;

UPDATE personprogramarea
SET activeflag = 0,
updatedon = now(),
updatedby = 'admin-D-27396'
WHERE objectid = 'cc7a48b4-dc1d-4321-ac2b-013749c871e5' AND activeflag =1;

UPDATE intakesnapshot 
SET jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I202000458847' AND activeflag=1;