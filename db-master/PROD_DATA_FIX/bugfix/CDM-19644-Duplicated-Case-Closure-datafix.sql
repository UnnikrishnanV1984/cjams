-- CDM-19644 - Duplicated case closure
/*
-- Issue Description: 
	Case #211020159400 : showing double in the user dashboard
	
-- Category/ Module:  Assign Case
-- Root cause: Two Disposition approval records active in routing

-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select 	activeflag, routingstatustypeid, * 
from 	routing 
where 	servicerequestnumber = '211020159400';

update 	routing
set 	activeflag = 0,
		updatedby = 'CDM-19644',
		updatedon = now()
where 	routingid = '02eb2730-81e4-4eaf-87f6-6f84a724a2f6' and activeflag = 1;