/*
Issue Description:CJAMS-68839
Category/Module: SDM
Root cause: This is not a defect.User requested to update  Near-Death/Serious Physical Injury in the SDM Maltreatment type needs to  Yes.
Fix provided: Data fix has been done to update the field from No to Yes as requested
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Not a code issue.
*/
update cjams.intakeservicerequestsdm
	set isseriousphysicalinjury = true,
		updatedby = 'CJAMS-68839',
		updatedon = now()
	where intakeservicerequestsdmid = '8c01a06b-88e7-4ce4-931d-93de12f931d3'
		and intakeserviceid = '1f3b3beb-9987-4093-8c8b-11a172de2ce3'; 
	
		
UPDATE cjams.intakedastaging
	SET updatedby = 'CJAMS-68839',
		updatedon = now(),
		jsondata = jsonb_set(jsondata, '{sdm}', 
			jsonb_set(jsondata->'sdm', '{isseriousphysicalinjury}', 'true'::jsonb))
WHERE
    intakenumber = 'I261014104666'
    AND activeflag = 1;
   
      UPDATE cjams.intakesnapshot
	SET updatedby = 'CJAMS-68839',
		updatedon = now(),
		jsondata = jsonb_set(jsondata, '{sdm}', 
			jsonb_set(jsondata->'sdm', '{isseriousphysicalinjury}', 'true'::jsonb))
WHERE
    intakenumber = 'I261014104666'
    AND activeflag = 1;