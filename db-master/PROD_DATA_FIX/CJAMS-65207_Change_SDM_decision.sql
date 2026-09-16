/*
Issue Description:CJAMS-65207
Category/Module: SDM
Root cause: User requested to update 'Serious Physical Injury selection' from Yes to no for a case
Fix provided: Data fix has been done to update the fields as requested
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Not a code issue.
*/


update cjams.intakeservicerequestsdm
	set isseriousphysicalinjury = true,
		updatedby = 'CJAMS-65207',
		updatedon = now()
	where intakeservicerequestsdmid = 'ffea9ded-2568-40f2-9fa7-785e6a3f7b25'
		and intakeserviceid = '791d8562-378d-402a-acfa-d34c61d2e69c' and activeflag=1; 
		

UPDATE cjams.intakedastaging
	SET updatedby = 'CJAMS-65207',
		updatedon = now(),
		jsondata = jsonb_set(jsondata, '{sdm}', 
			jsonb_set(jsondata->'sdm', '{isseriousphysicalinjury}', 'true'::jsonb))
WHERE
    intakenumber = 'I261013887447'
    AND activeflag = 1;
    
   
   UPDATE cjams.intakesnapshot
	SET updatedby = 'CJAMS-65207',
		updatedon = now(),
		jsondata = jsonb_set(jsondata, '{sdm}', 
			jsonb_set(jsondata->'sdm', '{isseriousphysicalinjury}', 'true'::jsonb))
WHERE
    intakenumber = 'I261013887447'
    AND activeflag = 1;
	