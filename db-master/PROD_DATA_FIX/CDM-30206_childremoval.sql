-- Update parent2signeddate

-- CDM-30206 - VPA Date
/*
-- Issue Description: 
	Please update the 2nd parent signature as 4/16/2014

-- Category/ Module: Child Removal - Removal Tab
-- Root cause: Provider Module Data Issue
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


select parent2signeddate from Intakeservreqchildremoval where intakeservreqchildremovalid = 'b618318c-e3f2-4a43-9a0e-6eb82347e2f6';

update Intakeservreqchildremoval set parent2signeddate='2014-04-16', updatedby = 'CDM-30206',
updatedon = now() where intakeservreqchildremovalid = 'b618318c-e3f2-4a43-9a0e-6eb82347e2f6';