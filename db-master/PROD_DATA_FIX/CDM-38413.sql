-- CDM-38413 - Need to remove IVe request
/*
-- Issue Description: 
	3173760: trying to close a case but it keeps giving me a notification that a request for IV-E needs to be made. no need of request so we need to revert the request.
   
-- Case ID: 3173760

   
-- Category/ Module: ivecaseclosure
-- Root cause: already IV-E request been sent.
-- Resolution: Removed the IV-E request  by setting active flag to 0.
-- Pull request# https://source.mdthink.maryland.gov/projects/DHSCJAMS/repos/cjams_db_scripts/pull-requests/11745/overview
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select * from ivecaseclosurereview where objectid='4b1b37e9-eb8c-49d8-9db6-71efdc3f5163';
select * from routing where objectid='1c0a5aca-f759-4e34-be06-3be733c91286';

UPDATE cjams.routing
SET   activeflag = 0,
	updatedby = 'CDM-38413',
	updatedon = now() WHERE routingid='88ef8592-a1b5-4df4-a34a-82910484314d'
	and activeflag = 1;

	UPDATE cjams.ivecaseclosurereview
SET   activeflag = 0,
	updatedby = 'CDM-38413',
	updatedon = now() WHERE objectid='4b1b37e9-eb8c-49d8-9db6-71efdc3f5163'
	and activeflag = 1;