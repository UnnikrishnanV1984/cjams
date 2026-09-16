/*
Issue Description:251022993570:Per SSA, to ensure consistent information is being reported to the General Assembly regarding Missing/Overdue Reasons, staff will submit a support ticket requesting that MDTHINK revise the drop down reasons to the most appropriate valid series of selections.Please add the following for the Alleged Victim drop-down: - Alleged Victim Unavailable - 
                  Family was contacted but unable to meet within the mandate-
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
    updatedby = 'CJAMS-59095'
where cpsresponsetimeractionsid = 'cae487a2-3ca6-4728-87a7-40b72db3ccde'
and intakeserviceid = '823583e2-0de7-46e4-b9f2-d97976f067f3';