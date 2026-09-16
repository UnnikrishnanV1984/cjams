/*

Root Cause:user error,  user incorrectly select the Child Fatality & Near-Death/Serious Physical Injury incorrectly
Fix Provided (Data Fix Only): Data fix is done to update the child fatality from No to Yes and Near-Death/Serious Physical Injury from yes to NO .
Case #:I261013940787
CJAMS PID: 4107931 (Caleb Snowden)
Data/Code fix ticket#:
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: this was a one time data correction specific  to a single referral.
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/



----Near-Death/Serious Physical Injury incorrectly - from Yes to No

update cjams.intakeservicerequestsdm
	set isseriousphysicalinjury = false,
		updatedby = 'CJAMS-69295',
		updatedon = now()
	where intakeservicerequestsdmid = 'a4de2d16-2924-4c45-9c4b-50c48bcd8f87'
		and intakeserviceid = '7cbc716e-5aa6-4dac-9330-406aae8075e5'; 
	
		
UPDATE cjams.intakedastaging
	SET updatedby = 'CJAMS-69295',
		updatedon = now(),
		jsondata = jsonb_set(jsondata, '{sdm}', 
			jsonb_set(jsondata->'sdm', '{isseriousphysicalinjury}', 'false'::jsonb))
WHERE
    intakenumber = 'I261013940787'
    AND activeflag = 1;
   
UPDATE cjams.intakesnapshot
	SET updatedby = 'CJAMS-69295',
		updatedon = now(),
		jsondata = jsonb_set(jsondata, '{sdm}', 
			jsonb_set(jsondata->'sdm', '{isseriousphysicalinjury}', 'false'::jsonb))
WHERE
    intakenumber = 'I261013940787'
    AND activeflag = 1;