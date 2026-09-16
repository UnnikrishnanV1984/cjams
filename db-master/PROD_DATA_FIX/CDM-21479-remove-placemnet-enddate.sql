/*
-- CDM-21479 - 

-- Issue Description: 
 Remove Enddate on Permanency Plan
  
-- Customer Email ID: tracie.cobb@maryland.gov

-- Root cause: Data fix to remove the end date
-- Pull request# : N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update placement 
set enddatetime = null, endtime = null,
	updatedby = 'CDM-21479', 
	updatedon = now()
where placementid = '32935a82-c382-43e7-b1c7-1e17479379b3';

update placementrevision set exitdate = null, updatedby = 'CDM-21479', 
	updatedon = now() where placementid = '32935a82-c382-43e7-b1c7-1e17479379b3' and activeflag = 1;