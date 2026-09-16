-- CDM-13574 - Missing auth approval
/*
-- Issue Description: 
   User request to forward Auth ID 1770461 LDSS Director level approval to the team (Not to the specific user)
   Current request is with Jennifer Neff.  
	
-- Case ID: 202109907168 -- kanisha.butler@maryland.gov
-- CLient ID: 4169544 (MARIA ELIZABETH MORRIS) - 0e2ee7f0-5268-4dcc-bb1c-a0a2b295a694
-- Auth ID: 1770461 - Service Log ID: 1993198

-- Category/ Module: Service Purchase Authorization (Case Management) 
-- Root cause: User error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select objectid, eventcode, routingstatustypeid, tosecurityusersid, updatedby, updatedon 
	from routing 
where routingid = '0eb67fda-1d2b-46b6-94c8-b9ba82ff8a23'
	and activeflag = 1 ;

update routing
set tosecurityusersid = null,
	eventcode = 'PCAUTHR',
	updatedby = 'CDM-13574',
	updatedon = now()
where routingid = '0eb67fda-1d2b-46b6-94c8-b9ba82ff8a23'
	and activeflag = 1 ;