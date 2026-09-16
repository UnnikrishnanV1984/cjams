/*
Issue Description:CJAMS-64873
Category/Module: SDM
Root cause: User requested to update 'Serious Physical Injury selection' from No to yes for a closed case
Fix provided: Data fix has been done to update the fiels as requested
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Not a code issue.
*/

-- Case Number 261023512597
update cjams.intakeservicerequestsdm
	set isseriousphysicalinjury = true,
		updatedby = 'CJAMS-64873',
		updatedon = now()
	where intakeservicerequestsdmid = 'c6f12c0c-c4a1-4208-9c72-3d2238f08f30'
		and intakeserviceid = 'ae53bb3b-a3a2-4561-aec0-d1c99a94ea42'; 
		
		
UPDATE cjams.intakedastaging
	SET updatedby = 'CJAMS-64873',
		updatedon = now(),
		jsondata = jsonb_set(jsondata, '{sdm}', 
			jsonb_set(jsondata->'sdm', '{isseriousphysicalinjury}', 'true'::jsonb))
WHERE
    intakenumber = 'I261013773662'
    AND activeflag = 1;
	
	
	
UPDATE cjams.intakesnapshot
	SET updatedby = 'CJAMS-64873',
		updatedon = now(),
		jsondata = jsonb_set(jsondata, '{sdm}', 
			jsonb_set(jsondata->'sdm', '{isseriousphysicalinjury}', 'true'::jsonb))
WHERE
    intakenumber = 'I261013773662'
    AND activeflag = 1;