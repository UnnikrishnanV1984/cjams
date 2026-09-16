/*
-- CDM-22737- 

-- Issue Description: 
 Unable to remove review record
  
-- Customer Email ID: susan.mceachron@maryland.gov

-- Root cause: Data fix to remove the review record
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update routing set activeflag = 0 , updatedby = 'CDM-22737', updatedon = now() where routingid in ('72ded9ce-251b-4303-a28a-ef4a89e38e19',
'3b74c1a8-8960-4ae8-a0d2-302572b2b72f',
'3306fcee-1707-4cd9-bf48-ba4227593e61',
'cd522df4-bc86-4ef8-84f3-e1f32dfb0ffc',
'6f42883e-c086-4676-8d9c-e00add67152f',
'f654d180-2e1d-4416-9422-3967dabbbd1d',
'f20704f4-8a0f-42ba-86a9-e9b9b3cffdf8',
'02adef5e-6ef6-4460-a5e3-64f004040e0c',
'4b498f31-f96a-437b-9edb-4bd141483f9b',
'f6f75120-075a-4643-9bee-9c9a98628d7a',
'80f27c7e-375b-46f6-abf9-36bae3997b51') and activeflag = 1;