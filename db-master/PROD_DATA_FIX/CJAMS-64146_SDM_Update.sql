/*
Issue Description:CJAMS-64146
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
		updatedby = 'CJAMS-64146',
		updatedon = now()
	where intakeservicerequestsdmid = 'bac08860-517b-4bf3-a24c-c39448b6ef35'
		and intakeserviceid = '70783d06-eb59-4855-8ae8-85f6b23bdf52'; 
		
		
UPDATE cjams.intakedastaging
	SET updatedby = 'CJAMS-64146',
		updatedon = now(),
		jsondata = jsonb_set(jsondata, '{sdm}', 
			jsonb_set(jsondata->'sdm', '{isseriousphysicalinjury}', 'true'::jsonb))
WHERE
    intakenumber = 'I251013499444'
    AND activeflag = 1;
	
	
	
UPDATE cjams.intakesnapshot
	SET updatedby = 'CJAMS-64146',
		updatedon = now(),
		jsondata = jsonb_set(jsondata, '{sdm}', 
			jsonb_set(jsondata->'sdm', '{isseriousphysicalinjury}', 'true'::jsonb))
WHERE
    intakenumber = 'I251013499444'
    AND activeflag = 1;
	