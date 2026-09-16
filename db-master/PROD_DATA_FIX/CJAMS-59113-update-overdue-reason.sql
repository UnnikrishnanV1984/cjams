/*
Issue Description:251022985992:Case #251022985992Per SSA, we are requesting a change to the Overdue Reason Box.Please change Alleged Victim to :-Alleged Victim unavailable-Attempted Face to Face-3-4 Attempts
                  Other Children:-Other children unavailable-Family was contacted but unavailable to meet within mandate
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
    updatedby = 'CJAMS-59113'
where cpsresponsetimeractionsid = 'e85cda02-e61d-4db1-927c-3fa7ed980418'
and intakeserviceid = '5bc5aa7a-27d4-42f6-8977-9a2707b3432c';