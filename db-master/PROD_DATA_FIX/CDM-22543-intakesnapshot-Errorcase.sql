-- CDM-22543-Case created in error 
/*
File Name: CDM-22543-intakesnapshot-Errorcase
-- Issue Description: 
   Case #3011907 was created with wrong Head of Household. Case needs to be deleted.
   CLient Email ID :lindsay.melvin@maryland.gov

-- Resolution: Updated the activeflag to zero in the intakesnapshot and routing table

-- Category/ Module: Case Management
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update intakesnapshot set activeflag = 0, updatedby = 'CDM-22543', updatedon = now()
where intakenumber = 'I221010273972' and activeflag = 1;

update routing set activeflag = 0, updatedby = 'CDM-22543', updatedon = now()
where objectid = 'I221010273972' and activeflag = 1;
