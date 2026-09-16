
/*
Issue: Mandate
Category/Module: CPS Response Timer Actions
Root cause: Need to update the case worker comments as the time was entered incorrectly. 
Fix provided: Data fix has been provided to update the case worker comments.
Data/Code fix ticket#: CJAMS-64985
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data entry error, no code fix needed.
*/
update cpsresponsetimeractions
set caseworkercomments ='contact ID # 15445446, the time was entered incorrectly. The correct time was 12:00 which is the time the worker arrived at the school to interview the  child. The interview started late as the worker was meeting with the social worker, and principal while the school looked for the student and prepared the student to complete the interview.',
updatedby ='CJAMS-64985',
updatedon =now()
where cpsresponsetimeractionsid ='1e7200e3-98ed-4cf4-8e20-c76b709c6042' and intakeserviceid = '7167adbb-8e2f-481b-9bae-cd68ce57aaca';