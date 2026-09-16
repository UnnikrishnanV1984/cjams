/*
Issue Description:CJAMS-64274
Category/Module: SDM
Root cause: User requested to update 'Serious Physical Injury selection' from No to yes for a closed case
Fix provided: Data fix has been done to update the fiels as requested
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Not a code issue.
*/

-- Case Number 251023256506
update cjams.intakeservicerequestsdm
	set isseriousphysicalinjury = true,
		updatedby = 'CJAMS-64274',
		updatedon = now()
	where intakeservicerequestsdmid = 'b75467a1-c1ed-4b98-8f54-be9b856520c4'
		and intakeserviceid = '55eee0f9-1f6c-4889-b0c5-a1b92c46596a'; 
		
		
UPDATE cjams.intakedastaging
	SET updatedby = 'CJAMS-64274',
		updatedon = now(),
		jsondata = jsonb_set(jsondata, '{sdm}', 
			jsonb_set(jsondata->'sdm', '{isseriousphysicalinjury}', 'true'::jsonb))
WHERE
    intakenumber = 'I251013487876'
    AND activeflag = 1;
	
	
	
UPDATE cjams.intakesnapshot
	SET updatedby = 'CJAMS-64274',
		updatedon = now(),
		jsondata = jsonb_set(jsondata, '{sdm}', 
			jsonb_set(jsondata->'sdm', '{isseriousphysicalinjury}', 'true'::jsonb))
WHERE
    intakenumber = 'I251013487876'
    AND activeflag = 1;
	