/*
Issue Description:CJAMS-68390
Category/Module: SDM
Root cause: user error, the Near-Death/Serious Physical Injury in the SDM Maltreatment type needs to be updated to NO as its incorrectly selected.
Fix provided: Data fix has been done to update the field from Yes to No  as requested
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Not a code issue.
*/



update cjams.intakeservicerequestsdm
	set isseriousphysicalinjury = false,
		updatedby = 'CJAMS-68390',
		updatedon = now()
	where intakeservicerequestsdmid = '143e0523-a49d-4d1b-ab61-9ed68ebc3ea3'
		and intakeserviceid = 'f6dca247-4365-4e55-8d25-0c0aaa7a57ff'; 
	
		
UPDATE cjams.intakedastaging
	SET updatedby = 'CJAMS-68390',
		updatedon = now(),
		jsondata = jsonb_set(jsondata, '{sdm}', 
			jsonb_set(jsondata->'sdm', '{isseriousphysicalinjury}', 'false'::jsonb))
WHERE
    intakenumber = 'I261014016177'
    AND activeflag = 1;
   
      UPDATE cjams.intakesnapshot
	SET updatedby = 'CJAMS-68390',
		updatedon = now(),
		jsondata = jsonb_set(jsondata, '{sdm}', 
			jsonb_set(jsondata->'sdm', '{isseriousphysicalinjury}', 'false'::jsonb))
WHERE
    intakenumber = 'I261014016177'
    AND activeflag = 1;