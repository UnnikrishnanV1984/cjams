/*
Issue Description:251023114392:This case needs a support ticket to fix that drop down as Instead of choosing Data Entry Error, this one should be "Alleged victim unavailable > Attempted face to face > 3-4 attempts.
Category/Module: Overdue Reason
Root cause:Data Entry error and user requested to update Over Due Reason dropdowns for late contact. For Alleged Victim, correct dropdown should be: Alleged Victim Unavailable and Attempted face to face and 3-4 Attempts.
Fix provided: Data fix to update the over due reason as Over Due Reason dropdowns for late contact. For Alleged Victim, correct dropdown should be: Alleged Victim Unavailable and Attempted face to face and 3-4 Attempts
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
    updatedby = 'CJAMS-62191'
where cpsresponsetimeractionsid = '94978379-b81c-4cff-a01d-d7c93f336c9c'
and intakeserviceid = 'b8f46922-6ce9-44e6-87ff-bddb1aa9428e';