/*
Category/Module: Overdue Reason
Root cause:Data Entry error and user requested to update the overdue reason for contact to alleged victim as Alleged Victim Unavailable - Family was contacted but unable to meet within the mandate  
Fix provided: Data fix to update the over due reason as Alleged Victim Unavailable - Family was contacted but unable to meet within the mandate 
Regression Impacts: N/A
Is Code fix Required?: NO
Code fix ticket#: N/A 
Reason why no related code fix: User error
*/

update cpsresponsetimeractions
set cpsresponsetimerreason1 = 'VAVU',
    cpsresponsetimerreason2 = 'VFCM',
    updatedon = now(),
    updatedby = 'CJAMS-67742'
where cpsresponsetimeractionsid = '9fb30eba-9981-40d9-bda9-4710688fde8f'
and intakeserviceid = '46e98f89-47a2-4c73-b172-3d4f3352ef4a';