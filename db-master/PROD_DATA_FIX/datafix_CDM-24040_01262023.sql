-- Update parent1id parent2id parent2signeddate

-- CDM-24040 - VPA Date
/*
-- Issue Description: 
	Dashboard:Edwin Bednar 2395053: The VPA agreement was signed by both parents on 10/2/12 and 10/3/13.
    The 2nd parents signature date is not reflected and requires updating.
    Parent 1 - Amy Bednar(PID#2064676) - 10/02/2012
    Parent 2 - Michael Bendar(PID#191285) - 10/03/2012

-- Category/ Module: Child Removal - Removal Tab
-- Root cause: Provider Module Data Issue
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


select parent1id,parent2id,parent2signeddate from Intakeservreqchildremoval where intakeservreqchildremovalid = 'be137677-9988-43c3-9b88-1698f7ca2bd2';

select * from Intakeservreqchildremoval where intakeservreqchildremovalid = 'be137677-9988-43c3-9b88-1698f7ca2bd2';

update Intakeservreqchildremoval set parent1id = '2064676',parent2id='191285',parent2signeddate='2012-10-03', updatedby = 'CDM-24040',
updatedon = now() where intakeservreqchildremovalid = 'be137677-9988-43c3-9b88-1698f7ca2bd2';