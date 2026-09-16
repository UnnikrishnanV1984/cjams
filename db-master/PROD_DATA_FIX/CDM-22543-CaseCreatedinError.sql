--CDM-22543-Case created in error
/*
File Name: CDM-22543-CaseCreatedinError
-- Issue Description: Referral # I221010267202 is not connected to new Service Case #3011907
   Email ID: lindsay.melvin@maryland.gov

-- Category/ Module: Case Management
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select * from cjams.createservicecase('ad9c4c56-12fe-4b41-bd1d-4485d5761979' , null, 1,'bacaf254-49bb-4df0-9ea1-c23cfd696d2a', 'intake', '');
