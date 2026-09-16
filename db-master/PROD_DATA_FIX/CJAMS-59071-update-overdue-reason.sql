/*
Issue Description:251023001033:Case #251023001033Per SSA, to ensure consistent information is being reported to the General Assembly regarding Missing/Overdue Reasons, staff will submit a support ticket requesting that MDTHINK revise the drop down reasons to the most appropriate valid series of selections.Please add the following drop-down selections for Alleged Victim: - Alleged Victim Unavailable - 
                  Family was contacted but unable to meet within the mandate
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
    updatedby = 'CJAMS-59071'
where cpsresponsetimeractionsid = '7d4b0549-8a3f-46b9-9847-817d830d08b1'
and intakeserviceid = '0a77e4f6-5a89-4d32-852c-eb10c4f41fd3';