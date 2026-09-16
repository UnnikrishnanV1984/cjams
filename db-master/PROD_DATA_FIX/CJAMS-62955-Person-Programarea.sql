/*
Issue:3168645:The youth is an OOH placement and is showing on the inactive tab. This client should be on the active tab as her case remains open.
Root Cause:User requested to  display the correct case number on the client OOH program assignment.
Fix Provided (Data Fix Only):Updated into intakeservreqchildremoval table.
Data/Code fix ticket#: CJAMS-62955
Regression Impacts:None 
Is Code fix Required?:no
Code fix ticket#: n/a
Reason why no related code fix:Data error
Backup before update/delete:
*/


update personprogramarea p 
set objectid  ='54887c94-2a28-42c3-bb98-36913de2622b',entityid  ='2020022502358',updatedby ='CJAMS-62955',updatedon =now()
where personprogramid  in ('57440aa5-cca6-4d31-a644-23f22bcd153e',
'1344481b-c525-43cb-88df-8f9297f8c608') and activeflag =1;


update personprogramarea p 
set objectid  ='c718edf2-348f-4eb4-8954-61a519cac7c9',entityid  ='3168645',updatedby ='CJAMS-62955',updatedon =now()
where personprogramid  in ('9e926cf7-ce53-4c93-8b41-27b1d1af6fd5',
'ff7afcdc-3d9a-4d38-bbe5-bde104f18855','ff0ffa64-8397-41cb-9510-388612129d04') and activeflag =1;
