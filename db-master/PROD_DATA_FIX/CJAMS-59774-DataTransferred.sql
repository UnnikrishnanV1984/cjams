/*
Issue:251030491597:I was just assigned this case. In preparation for meeting the family, when I opened this case, I discovered that there is NO information in the 'SUmmary' tab. The children's names and DOB's are listed. There is no address information, there is no information under SUMMARY, regarding created date, supervisor name, service type, etc. The CPS Intake Report is missing. The Narrative is missing. I need the information that should have transferred with this case, so that I can work this case!
Root Cause:The first service case 251030491597 does not have intake information and the second service case 251030491598 has all the intake information. So, user wants to move all the case and person profile data from the case 251030491597 to the case 251030491598.
Fix Provided (Data Fix Only):Data fix was done by Updated intakedastaging table and inserted a record into routing table..
Data/Code fix ticket#: CJAMS-59774
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: only data issue , not a functional issue.
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/
--person 
update personprogramarea 
set entityid = '251030491598',objectid = 'f740e368-f891-46e9-a030-ef1e1f68bf2d',updatedby = 'CJAMS-59774', updatedon = now()
where personid in ('66bca49c-ce7b-4305-ae6d-edd38a62a6eb',
'2b1b202a-e0aa-4472-9732-e34d6810d55d',
'8ed3dfe5-624f-4903-a5aa-7a235544c044',
'c48b4f66-67b4-45c3-bc63-f6b5e713188b',
'482dad29-fa9d-4d50-b73c-c548c0c38435',
'f3569684-6711-4bc9-8af9-363d42ea6718',
'7135e647-b93a-464b-a06d-da93a27e0f0f',
'8ab1b0ed-3d6e-40d3-be51-3ba307aca28e',
'bbaf1ee2-e906-4e49-83f1-232f076f63e6',
'3c9291e6-c11c-4556-90fc-b0deb92cabf5') and activeflag=1;

update personprogramarea
set activeflag = 0 ,updatedby = 'CJAMS-59774', updatedon = now()
where personprogramid = 'c26d409b-da9d-468d-bda6-3b11d81bf24d' and activeflag =1;

update actor
set servicecaseid = 'f740e368-f891-46e9-a030-ef1e1f68bf2d',updatedby = 'CJAMS-59774', updatedon = now()
where actorid in (
'0e6170e8-ec09-4764-a10a-43b45ba08ab9',
'34227b84-6ad9-4cd6-9454-43f80f7c5b4a',
'38f3b0a4-d631-4841-bdd7-d0259408f4ab',
'3c0f1990-0d31-4975-ae37-3c2eff30a36a',
'496c6c2d-0615-46c8-af7b-799ae6d719a7',
'648978c9-8490-45eb-af93-79cf1e9c095a',
'db77f81b-7f08-43a6-a7cb-c9c7ad7d6a4d',
'e0c5f030-d9fd-413d-9a23-34cc0cfc7ce3',
'e1a43e49-6ef1-4428-96ef-f1a1329b7b44',
'ef796abd-460d-4bc1-9cf8-b2ee383a90f0') and activeflag=1;


update intakeservicerequestactor
set servicecaseid = 'f740e368-f891-46e9-a030-ef1e1f68bf2d',updatedby = 'CJAMS-59774', updatedon = now()
where intakeservicerequestactorid in 
('26924f10-d39e-4ed1-a1aa-e690b8ff16d6',
'dbe704a9-1123-4876-a327-d5a66a786fec',
'8524990d-cd6c-4670-8a24-c35395d422e1',
'824f36be-2620-45e8-8f81-f3c07f6f0cd2',
'53a2258c-82f0-4f47-a8b8-4b38ff7ffea4',
'9b6d1246-81f9-4258-83a6-3c686000f8b8',
'bd53bd4c-fc00-45ca-829a-7da4498886fc',
'52ebcaed-5db9-473f-befc-3c4c9bd72189',
'fecf7b0a-6f24-4fba-afd7-29c428f9a9a0',
'85f8fdc8-b777-47e9-a083-97c12a32b525',
'effbbd3a-3176-4b10-9f4b-f51b14721f3b',
'604898be-9ba1-4035-8905-9fb6f2066123',
'b96db675-c2c5-40fb-a14d-ce387cc58f47',
'4ec13668-160f-47fe-aec5-b6461dd99ef8') and activeflag=1;


update collateral
set caseid = 'f740e368-f891-46e9-a030-ef1e1f68bf2d',updatedby = 'CJAMS-59774', updatedon = now()
where collateralid in  ('38e91209-4315-471b-9cc8-0f091374fa3b','6b1b7278-146d-49a5-8322-1b0eef5f13bf','66e57e26-80c1-4e3f-8c55-9db65d79aeeb')and activeflag=1;

--Assement
 update assessment
set servicecaseid = 'f740e368-f891-46e9-a030-ef1e1f68bf2d',updatedby = 'e6e2fe7b-cbab-48c0-b7ef-06bbffd7ad26', updatedon = now()
where assessmentid = '4335f21e-8e61-4343-a981-44cc2e839df5' and activeflag=1;

update assessment_history
set servicecaseid = 'f740e368-f891-46e9-a030-ef1e1f68bf2d',updatedby = 'e6e2fe7b-cbab-48c0-b7ef-06bbffd7ad26', updatedon = now()
where assessmentid = '4335f21e-8e61-4343-a981-44cc2e839df5' and activeflag=1;

update assessment
set servicecaseid = 'f740e368-f891-46e9-a030-ef1e1f68bf2d',updatedby = 'e6e2fe7b-cbab-48c0-b7ef-06bbffd7ad26', updatedon = now()
where assessmentid = '17e5225b-2922-4aa0-a1a9-6368f1f2afc7'and activeflag=1;

update assessment_history
set servicecaseid = 'f740e368-f891-46e9-a030-ef1e1f68bf2d',updatedby = 'e6e2fe7b-cbab-48c0-b7ef-06bbffd7ad26', updatedon = now()
where assessmentid = '17e5225b-2922-4aa0-a1a9-6368f1f2afc7'and activeflag=1;

update assessment
set servicecaseid = 'f740e368-f891-46e9-a030-ef1e1f68bf2d',updatedby = 'e6e2fe7b-cbab-48c0-b7ef-06bbffd7ad26', updatedon = now()
where assessmentid = '5a17f8d1-9d49-4dff-84b4-41123a69f2b6'and activeflag=1;


update assessment_history
set servicecaseid = 'f740e368-f891-46e9-a030-ef1e1f68bf2d',updatedby = 'e6e2fe7b-cbab-48c0-b7ef-06bbffd7ad26', updatedon = now()
where assessmentid = '5a17f8d1-9d49-4dff-84b4-41123a69f2b6'and activeflag=1;

--Assignments
update caseassignment
set objectid = 'f740e368-f891-46e9-a030-ef1e1f68bf2d',updatedby = 'CJAMS-59774', updatedon = now()
where caseassignmentid = 'c39c0c6a-2d61-4a6f-bb6c-d43b05390789' and activeflag=1;

update caseassignment
set startdate = '2025-05-16 08:30:25',updatedby = 'CJAMS-59774', updatedon = now()
where caseassignmentid = '81afc18c-810b-4d37-80c1-4255aa417e08' and activeflag=1;






--Documents
update  progressnote
set servicecaseid = 'f740e368-f891-46e9-a030-ef1e1f68bf2d', entitytypeid = 'f740e368-f891-46e9-a030-ef1e1f68bf2d',updatedby = 'CJAMS-59774', updatedon = now()
where progressnoteid in 
('be2bfb75-146f-4729-aaba-06d9e33406eb',
'3a2803e3-b002-4957-b326-d99ea82e5272',
'e02ff182-2e04-41e3-8c74-bea9cd6fe27d',
'b4787cb6-9055-4d44-87fd-cf12d7cefcec',
'04e4225b-c3d5-4203-858c-d448c51fbab2',
'758a3ac7-ad5e-4c25-9cdb-c7c1332f14bb',
'3a429af1-f98c-4856-bcf7-5e60d7329814',
'108b0e46-e1eb-436a-aa33-84c24d170471') and activeflag=1 ;



--Documents
update documentproperties 
set servicecaseid = 'f740e368-f891-46e9-a030-ef1e1f68bf2d', updatedby = 'CJAMS-59774', updatedon = now()
where documentpropertiesid in (
'797bdbcd-076e-4278-af5b-0a5ca37a276e', 
'66013580-84f0-441d-acf7-94b0e3ece24e', 
'750f8811-3cbb-4385-91b9-ce068232eec6',
'35be881b-76d7-485c-9f33-4680d3318f82',
'5cab99b9-dbed-47ca-89d8-7055be464575', 
'7ab88676-1afd-4f95-9da5-d22cee3b85ad', 
'766dc46e-e717-42d8-bbf2-92e451d6aafa') and activeflag=1;


--payments
update tb_payment_detail
set case_id = '251030491598' ,update_ts = now(), update_user_id = 'CJAMS-59774'
where payment_id = '4722602' and delete_sw = 'N';


update tb_service_log
set case_id = '251030491598' ,update_ts = now(), update_user_id = 'CJAMS-59774'
where service_log_id = '3663211' and delete_sw = 'N';


update tb_slpa_snapshot
set case_id = '251030491598' ,update_ts = now(), update_user_id = 'CJAMS-59774'
where authorization_id = 3783458 and delete_sw = 'N';

