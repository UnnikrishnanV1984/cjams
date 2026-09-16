
/*
Issue Description: CJAMS-67922 - Data Fix for Overdue Reason
Category/Module: Case Management
Root cause: 261023690559:The overdue reason reason timer should be changed to reflect. Victim unavailable, 1-2 attempts. 
Fix provided: Data fix has been promoted to update 261023690559:The overdue reason reason timer should be changed to reflect. Victim unavailable, 1-2 attempts. 
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix: Data fix 
*/

update cpsresponsetimeractions
set cpsresponsetimerreason1 = 'VAVU',
    cpsresponsetimerreason2 = 'VAFF',
    cpsresponsetimerreason3 = 'V12F',
    updatedon = now(),
    updatedby = 'CJAMS-67922'
where cpsresponsetimeractionsid = 'd9bc7836-5b41-40b8-b731-928e48b55172'
and intakeserviceid='012f9352-f1d4-40a6-8295-8a438e51f98b';