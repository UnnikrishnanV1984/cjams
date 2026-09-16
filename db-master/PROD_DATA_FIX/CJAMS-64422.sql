/*
Issue Description:CJAMS-64422
Category/Module: Intake Narrative
Root cause: Screenout Override intakes are hanging when there is no data in Addendum section
Fix provided: the reason for the issue is when saving Sreenout Override intakes with out addendum narrative, updated date is saving as "Invalid Date' in DB 
			and code not able to handle that data in date field when we open the intake.
			Data fix has been done to update the data to null for these intakes as a temporary fix
Regression Impacts: N/A
Is Code fix Required?: Code fix will be deployed thru another CIDM next week
Code fix ticket#: N/A
Reason why no related code fix: Not a code issue.
*/

UPDATE cjams.intakedastaging
	SET updatedby = 'CJAMS-64422',
		updatedon = now(),
		jsondata = jsonb_set(jsondata, '{General}', 
			jsonb_set(jsondata->'General', '{addendumNarrativeUpdatedAt}', 'null'::jsonb))
WHERE
    intakenumber = 'I261013677952'
    AND activeflag = 1;
	