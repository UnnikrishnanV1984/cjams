/*
Issue Description:CJAMS-66717
Category/Module: SDM
Root cause: This is not a defect. The CPS IR # 261023557863 is closed on 03/26/2026 and the Near-Death/Serious Physical Injury in the SDM Maltreatment type needs to be updated to Yes.
Fix provided: Data fix has been done to update the field from No to Yes as requested
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Not a code issue.
*/

update cjams.intakeservicerequestsdm
	set isseriousphysicalinjury = true,
		updatedby = 'CJAMS-66717',
		updatedon = now()
	where intakeservicerequestsdmid = '569704ae-0597-4263-b8ad-b97b2140bb72'
		and intakeserviceid = 'aeae00de-2810-4dfe-b386-3c428df29f53'; 
	
		
UPDATE cjams.intakedastaging
	SET updatedby = 'CJAMS-66717',
		updatedon = now(),
		jsondata = jsonb_set(jsondata, '{sdm}', 
			jsonb_set(jsondata->'sdm', '{isseriousphysicalinjury}', 'true'::jsonb))
WHERE
    intakenumber = 'I261013821458'
    AND activeflag = 1;
   
      UPDATE cjams.intakesnapshot
	SET updatedby = 'CJAMS-66717',
		updatedon = now(),
		jsondata = jsonb_set(jsondata, '{sdm}', 
			jsonb_set(jsondata->'sdm', '{isseriousphysicalinjury}', 'true'::jsonb))
WHERE
    intakenumber = 'I261013821458'
    AND activeflag = 1;