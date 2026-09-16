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
    updatedby = 'CJAMS-59106'
where cpsresponsetimeractionsid = '6d49d5de-a19c-427c-81bc-93aa647e9b38'
and intakeserviceid = '476c28a7-7c34-4d4a-b628-90869189a04d';