/*-- Category/ Module: Placement (Case Management) 
-- Root cause: Data Issue 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update placementcpahomes
set entrydt = '2022-11-29 00:00:00',
entrytm  = '2022-11-29 19:00:00',
	updatets = now(),
	updateuserid = 'CDM-30007'
where placementcpahomeid = 'afc12a39-95a8-4cc7-9a47-40ab8b2fbaea'
	and activeflag = 1 ;


