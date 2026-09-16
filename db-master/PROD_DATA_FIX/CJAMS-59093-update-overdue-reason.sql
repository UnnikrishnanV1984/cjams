/*
Issue Description:CJAMS-59093 Must change the Overdue Reason Box drop-down
Category/Module: Overdue Reason
Root cause:Data Entry error and user requested to update the overdue reason values to Alleged Victim Unavailable - Family was contacted but unable to meet within the mandate  
Fix provided: Data fix to update the over due reason as requested
Regression Impacts: N/A
Is Code fix Required?: NO
Code fix ticket#: N/A 
Reason why no related code fix: User error
*/

update cpsresponsetimeractions
set cpsresponsetimerreason1 = 'VAVU',
    cpsresponsetimerreason2 = 'VFCM',
    updatedon = now(),
    updatedby = 'CJAMS-59093'
where cpsresponsetimeractionsid = '05d5669a-96e7-4b17-8fe6-a9ed42c16c43'
and intakeserviceid = 'b2e1cc5c-4c47-445a-abb3-60e9f4a443f4';