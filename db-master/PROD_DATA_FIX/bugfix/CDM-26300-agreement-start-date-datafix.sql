-- CDM-26300 - Agreement start date
/*
-- Issue Description: 
 	User requested to do the following changes:
	1. Change the court order date from 10/22/2018 to 10/04/2018
	2. The change on the court order start date should reflected on the Agreement start date.

	
-- Category/ Module: GAP
-- Root cause: User Request
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select 	* from intakeservreqcourtorder i 
where 	intakeservreqcourtorderid = '26a5d791-3f41-4686-be6d-61211a17cb55';

update 	intakeservreqcourtorder 
set 	courtorderdate = '2018-10-04 00:00:00.000',
		updatedby = 'CDM-26300',
		updatedon  = now()
where 	intakeservreqcourtorderid = '26a5d791-3f41-4686-be6d-61211a17cb55';

select 	startdate , enddate , * from gapagreement g 
where 	gapagreementid = '749ffce4-ec0d-420d-8562-39b287f2dd3e';

update 	gapagreement
set 	startdate = '2018-10-04 00:00:00.000',
		updatedby = 'CDM-26300',
		updatedon  = now()
where 	gapagreementid = '749ffce4-ec0d-420d-8562-39b287f2dd3e';