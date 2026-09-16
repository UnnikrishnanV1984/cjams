-- CDM-26319 - Cannot approve subsidy rate
/*
-- Issue Description: 
	1. User requested to change the request approval submitted caseworker name to lindaj.luallen@maryland.gov 
		and route the approval request to shaquan.brown@maryland.gov
	
-- Category/ Module: Routing
-- Root cause: Duplicate note
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update 	routing 
set 	tosecurityusersid = '3ca8e63d-f885-445b-aab9-24456e91ad4a',--Shaquan Brown
		fromsecurityusersid = 'ceca7825-35d6-41bb-bfc9-df3256d9a1d9', --LindaLuallen
		teamid = 'b50f2419-42ba-4ab6-84ab-5172917d2d77',
		updatedby = 'CDM-26319',
		updatedon = now(), activeflag = 1
where 	routingid = '5ee5c22e-068b-40d4-bcf0-9b48744f57fc';

