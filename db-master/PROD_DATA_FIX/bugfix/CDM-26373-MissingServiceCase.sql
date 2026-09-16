-- CDM-26373- Missing Service Case
/*
   File Name: CDM-26373-MissingServiceCase
-- Issue Description: 
    For the intake# I221010333137 It is a ROA, was unable to find the Service case and assign it to the correct worke
    Customer Email ID:courtney.wunderlich@maryland.gov
  
-- Resolution: Creating a service case from backedn by running the select query

-- Category/ Module: Case Management
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

*/	
	

select * from cjams.createservicecase('816e31de-d32a-4a08-b385-5a1d84b60b2e',NULL,1,'6e0584d0-90b0-4d46-87ce-004e6b740419','intake');