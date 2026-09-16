/*
Issue Description:CJAMS-64779
Category/Module: SDM
Root cause: User requested to update 'Serious Physical Injury selection' from No to yes .
Fix provided: Data fix has been done to update the field as requested
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Not a code issue.
*/

update cjams.intakeservicerequestsdm
	set isseriousphysicalinjury = true,
		updatedby = 'CJAMS-64779',
		updatedon = now()
	where intakeservicerequestsdmid = 'a9265dc2-3280-44ff-a3f4-105984e7c40a'
		and intakeserviceid = 'a2e99b8c-6a7c-4fb5-99fe-2d563300830e'; 
	
		
UPDATE cjams.intakedastaging
	SET updatedby = 'CJAMS-64779',
		updatedon = now(),
		jsondata = jsonb_set(jsondata, '{sdm}', 
			jsonb_set(jsondata->'sdm', '{isseriousphysicalinjury}', 'true'::jsonb))
WHERE
    intakenumber = 'I261013782378'
    AND activeflag = 1;
   
      UPDATE cjams.intakesnapshot
	SET updatedby = 'CJAMS-64779',
		updatedon = now(),
		jsondata = jsonb_set(jsondata, '{sdm}', 
			jsonb_set(jsondata->'sdm', '{isseriousphysicalinjury}', 'true'::jsonb))
WHERE
    intakenumber = 'I261013782378'
    AND activeflag = 1;