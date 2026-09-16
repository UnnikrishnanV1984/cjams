/*
-- Issue Description: 
-- CDM-27195: Payment did not get to Finance
-- Category/ Module: Service Purchase Authorization (Case Management) 
-- Root cause: Routing ToRoleId is CWCW
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

select 	* from routing
where 	routingid = 'ec5556b5-219b-484c-8744-1bb3ea792e96';

-- toroleid = 'FNSFW'
update 	routing
set 	toroleid = 'FNSFW',
		teamid = '253a6704-7f3f-4bb5-a40e-8a3dd71078ef',
		updatedby = 'CDM-27195',
		updatedon = now()
where 	routingid = 'ec5556b5-219b-484c-8744-1bb3ea792e96' and activeflag = 1;
