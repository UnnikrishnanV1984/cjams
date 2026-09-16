/*
   Issue Description: CDM-23745
   Category/ Module  : Assessments
   Root cause: User requested to change the dates and updatedBy from Brenda Carr to Alison Lillis
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


---SAFE-C = 5/20/22 and Updated By to Alison Lillis
select 	submissiondata, * from assessment
where 	objectid = '4e5e9c38-73f1-44b8-826a-353f5e6b246f' and assessmenttemplateid = '0f01e16c-73db-42d8-ad84-04eeb5e26418' and activeflag = 1;
--audit columns should not be updated

update 	assessment
set 	submissiondata = jsonb_set(submissiondata, '{dateassessmentinitiated}', '"2022-05-20T23:30:00.000Z"'), updatedby = 'd248cc79-53fe-4669-b62a-174c01e19eca'
		--, updatedon = now()
where 	objectid = '4e5e9c38-73f1-44b8-826a-353f5e6b246f' and assessmenttemplateid = '0f01e16c-73db-42d8-ad84-04eeb5e26418' and activeflag = 1;

update 	assessment
set 	submissiondata = jsonb_set(submissiondata, '{safetyassessmentcompletiondate}', '"2022-05-20T23:30:00.000Z"')
		--, updatedby = 'CDM-23745', updatedon = now()
where 	objectid = '4e5e9c38-73f1-44b8-826a-353f5e6b246f' and assessmenttemplateid = '0f01e16c-73db-42d8-ad84-04eeb5e26418'  and activeflag = 1;

----MFIRA = 6/22/222 and Updated By to Alison Lillis
-- No need to update date, only UpdatedBy as per the request
update 	assessment
set 	updatedby = 'd248cc79-53fe-4669-b62a-174c01e19eca'
where 	objectid = '4e5e9c38-73f1-44b8-826a-353f5e6b246f' and assessmenttemplateid = 'ba9b5838-e8ab-434b-9871-3611e86c314d' and activeflag = 1;

-----CANS-F = 07/14/2022 and Updated By to Alison Lillis
-- No need to update date, only UpdatedBy as per the request
update 	assessment
set 	updatedby = 'd248cc79-53fe-4669-b62a-174c01e19eca'
where 	objectid = '4e5e9c38-73f1-44b8-826a-353f5e6b246f' and assessmenttemplateid = 'e348d7c4-a392-447a-ba42-17078941a721' and activeflag = 1;