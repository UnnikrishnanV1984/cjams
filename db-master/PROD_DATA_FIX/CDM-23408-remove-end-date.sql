/*
-- CDM-23408- 

-- Issue Description: 
 Unable to remove the end date
  
-- Customer Email ID: tracie.cobb@maryland.gov

-- Root cause: Data fix to remove end date on child removal
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- 2022-04-21 17:30:00.000
update intakeservreqchildremoval set exitdate = null, updatedon = now(), updatedby = 'CDM-23408'
where intakeservreqchildremovalid = 'bd3a0bf6-5b22-4518-8e74-bdc6ad4b8859';

--2022-04-21 00:00:00.000
update personprogramarea set enddate = null, updatedon = now(), updatedby = 'CDM-23408'
where personprogramid = '6dd3722b-b16d-45c7-bfe1-cab288b9290f';