UPDATE intakeservicerequest  
SET   
    actiontype = null, intakeservicerequestclassid = '00000000-0000-0000-0000-000000000000', activeflag = 0, 
    updatedby = 'admin-D-27396', updatedon = now() 
WHERE 
    servicerequestnumber = '2020066016597'
AND intakeserviceid = '3d3b151e-0805-490f-b748-e52cf7981adb' 
AND activeflag = 1;

UPDATE personprogramarea
SET activeflag = 0,
updatedon = now(),
updatedby = 'admin-D-27396'
WHERE objectid = '3d3b151e-0805-490f-b748-e52cf7981adb' AND activeflag =1;

UPDATE intakesnapshot 
SET jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I202000458800' AND activeflag=1;