--CDM-23824-empty case
/*
   File Name: CDM-23824-routing-emptycase
-- Issue Description: 
    For the case 221030017053 -An empty case was created and needs to be removed.
	and user wants us to delete from approval box.
    Customer Email ID:pam.scalio@maryland.gov
  
-- Resolution: Updated the activeflag to zero in the routing, servicecase, servicecasedisposition, caseassignment table

-- Category/ Module: Case Management
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

*/

update
	routing
set
	activeflag = 0,
	updatedon = now() ,
	updatedby = 'CDM-23824'
where
	routingid in ('c0d939f6-e64c-41b7-9664-08d131696b06')
	and activeflag = 1;

update
	servicecase
set
	activeflag = 0,
	updatedby = 'CDM-23824',
	updatedon = now()
where
	servicecasenumber = '221030017053';

update
	servicecasedisposition
set
	activeflag = 0,
	updatedby = 'CDM-23824',
	updatedon = now()
where
	servicecaseid = 'c396b633-2724-47fd-946e-30f204f6ff5d';

update
	caseassignment
set
	activeflag = 0,
	updatedby = 'CDM-23824',
	updatedon = now()
where
	objectid = 'c396b633-2724-47fd-946e-30f204f6ff5d';

update
	routing
set
	activeflag = 0,
	updatedby = 'CDM-23824',
	updatedon = now()
where
	objectid = 'c396b633-2724-47fd-946e-30f204f6ff5d';