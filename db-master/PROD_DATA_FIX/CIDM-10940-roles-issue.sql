/*
-- Issue Description:  CIDM-10940
-- Category/ Module: Payments
-- Root cause: User is not having the Finance Supervisor role, so that is the reason user is not able to approvbe the finance write-off request
-- Fix Provided: Adding financial supervisor Role to the USER larissa.royal@montgomerycountymd.gov
-- Regression Impacts: N/A 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update teammember 
set roletypekey = 'FNSFS',
    updatedby = 'CIDM-10940',
    teamid = 'a7f4e8e4-a52e-4a5b-be32-07e18959cf9c',
	updatedon = now()
where teammemberid = '8f52d819-681a-4271-a152-e0bd6012b573'
and activeflag = 1;

update rolemapping 
set roleid = 1053, 
	updatedby = 'CIDM-10940',
	updatedon = now()
where principalid = '4811' and activeflag =1 and id = 123812937;