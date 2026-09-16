/*
Issue Description:CJAMS-60279  Incorrect received Date on Referral
Category/Module: Intake 
Root cause: intake I251013310111, the received date/time should be 6/19/2025 @12:29 pm
Data/Code fix ticket#: CJAMS-60279
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Migration issue and correction is needed as a data fix for the issue.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update intakedastaging 
set daterecieved = '2025-06-19 12:29:00'
		, timerecieved = '2025-06-19 12:29:00'
		, jsondata = REPLACE(jsondata::text, '"RecivedDate": "06/20/2025 08:03:55 AM"', '"RecivedDate": "06/19/2025 12:29:00 PM"')::json
		, updatedby = 'CJAMS-60279'
		, updatedon = now()
where intakenumber = 'I251013310111' and activeflag = 1 ;

update intakesnapshot 
set 	jsondata = REPLACE(jsondata::text, '"RecivedDate": "06/20/2025 08:03:55 AM"', '"RecivedDate": "06/19/2025 12:29:00 PM"')::json
        , updatedby = 'CJAMS-60279'
		, updatedon = now()
where intakenumber = 'I251013310111' and activeflag = 1;

update intakeservicerequest set intakedaterecieved = '2025-06-19 12:29:00', 
        updatedby = 'CJAMS-60279'
		, updatedon = now()
 where IntakeNumber = 'I251013310111';	