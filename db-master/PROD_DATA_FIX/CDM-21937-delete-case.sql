/*
-- CDM-21937 - 

-- Issue Description: 
 Unable to delete the case
  
-- Customer Email ID:markeeta.dixon@maryland.gov

-- Root cause: Data fix updated the activeflag to 0
-- Pull request#: N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select * from recordintakeadministrativeoverride('{"intakeNumber": "I221010261097",
"overrideComment": "changing to screen out",
"overrideDate": "2022-04-15T17:11:42.828Z",
"overrideDecision": null,
"overrideReason": "RISI",
"securityusersid": "dced7693-797d-4984-9a94-8b36d9ee44e4"}');