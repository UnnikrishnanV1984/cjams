/*
Issue Description:251022988369:Case was accepted as a Neglect on 1/27. On 1/30 the social worker attempted to meet with the children and their aprents. Multiple attempts were made to meet with the initial contact caregiver . Caregiver was unable to meet within the mandate. CHnage from data error to family unavailibility and select 3-4 attempts because the worker went to home, the school, called and left letter.
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
    updatedby = 'CJAMS-59169'
where cpsresponsetimeractionsid = '821d23d4-a916-4900-ae5d-e6691aa1055f'
and intakeserviceid = '159c0845-49e6-47f5-a127-7247c798f825';