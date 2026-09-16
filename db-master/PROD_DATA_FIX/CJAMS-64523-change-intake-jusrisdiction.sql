/*
Issue: CJAMS-64523 Save Button gone
Category/Module: Intake
Root cause: The Intake was transferred from Carrol county to Montgomery county and the Jurisdiction is still displayed as Carrol county.
            We need a data fix to resolve it.
Fix provided:  Data fix has been done to change the jurisdiction from Carrol to Montgomery for the intake#I261013722735.
Data/Code fix ticket#: CJAMS-64523
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Intake county changed and data fix needed for this issue.
*/

--select jsondata->'General'->'countyid',*from intakedastaging where intakenumber = 'I261013722735' and activeflag =1;

UPDATE intakedastaging
SET updatedby = 'CJAMS-64523', updatedon = now(), 
jsondata = 	jsonb_set(jsondata, '{General}', 
				jsonb_set(jsondata->'General', '{countyid}', '"f6ab02d5-c386-4659-8810-687fc191a967"'))
WHERE intakenumber = 'I261013722735' AND activeflag=1;