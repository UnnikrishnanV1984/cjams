-- CDM-28285 -  Annual Adoption Review Case
/*
-- Issue Description: 
  This case was mistakenly placed on my tree an Annual Adoption Review Case 3136379, Anthony I Leneau from Baltimore City. I work in CPS in Prince George's County

-- Category/ Module: Adoption Annual Review Case 
-- Root cause: User Request
-- Pull request# TBD
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

-- update the caseworker name to Rose Underwood and route the approval to Teresa Boston 

update 	routing
set 	fromsecurityusersid = '7931939d-b256-4735-b2de-5e96c615d699',
		tosecurityusersid = 'c38b3a54-337e-4d4b-98f2-06c6c65cdfe7',
		updatedby = 'CDM-28285',
		updatedon = now()
where 	routingid = '194aaf96-78cd-4661-80dc-2ca4a79d9ee3' and activeflag = 1;