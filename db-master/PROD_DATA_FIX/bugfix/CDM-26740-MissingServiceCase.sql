-- CDM-26740- Unable to assign case/missng service case
/*
   File Name: CDM-26740-MissingServiceCase
-- Issue Description: 
    For the intake# I221010338900 intake referral was approved in CJAMS, but the system never generated a service case so I have nothing to assign.
    Customer Email ID:genae.elsey@maryland.gov
  
-- Resolution: Creating a service case from backedn by running the select query

-- Category/ Module: Case Management
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

*/

select * from cjams.createservicecase('2ac11cd3-246a-444b-afea-c117b98ff62b', null, 1, '7c625704-a34e-4f8a-a20d-e9c206527370', 'intake', '');