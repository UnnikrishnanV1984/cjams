/*
Issue Description:2251022991591:Closed case no longer shows Over Due Reason dropdowns for late contact. For Alleged Victim, correct dropdown should be: Alleged Victim Unavailable and 3-4 Attempts.
Category/Module: Overdue Reason
Root cause:Data Entry error and user requested to update Over Due Reason dropdowns for late contact. For Alleged Victim, correct dropdown should be: Alleged Victim Unavailable and 3-4 Attempts.
Fix provided: Data fix to update the over due reason as Over Due Reason dropdowns for late contact. For Alleged Victim, correct dropdown should be: Alleged Victim Unavailable and 3-4 Attempts
Regression Impacts: N/A
Is Code fix Required?: NO
Code fix ticket#: N/A 
Reason why no related code fix: User error
*/

update cpsresponsetimeractions
set cpsresponsetimerreason1 = 'VAVU',
    cpsresponsetimerreason2 = 'VAFF',
    cpsresponsetimerreason3 = 'V34F',
    updatedon = now(),
    updatedby = 'CJAMS-59091'
where cpsresponsetimeractionsid = '41dc0af5-96a2-4791-9ae7-8bf26095bf5c'
and intakeserviceid = 'd35af879-b204-48f8-b36d-26b19af95d27';