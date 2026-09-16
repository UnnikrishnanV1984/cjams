/*
-- CDM-22382- 

-- Issue Description: 
 Unable to remove review records
  
-- Customer Email ID: wanda.nolt@maryland.gov

-- Root cause: Data fix to remove the review records
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update routing set activeflag =0, updatedon = now(), updatedby = 'CDM-22382'
where routingid in (
'cbb70ea2-2b1f-4d89-820e-fbf3ee215569',
'71d0017c-36bb-4fef-8e08-fff8ee0e76f7',
'679a4dd6-893d-433c-99a7-cb8a0fe172b3',
'f558aff4-8bb1-4977-9534-7e2697a3e93a',
'ab657f9c-3910-47a3-9316-f3d4ee6f9e4f',
'a621ab63-b7bc-4d9d-ab7a-b32269671a82'
) and activeflag =1;