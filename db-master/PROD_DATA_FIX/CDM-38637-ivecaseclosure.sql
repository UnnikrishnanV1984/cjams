-- CDM-38637 - Title IV-E Eligibility Determinations
/*
-- Issue Description: 
	3117128: We are attempting to close a case in which the caregiver is declining family preservation services. When we attempt to close the case, it shows that the Title IV-E Eligibility Determinations are not completed. I looked through the case to see if I could figure out why that box was not checked, but am unable to figure it out. 
   
-- Case ID: 3117128

   
-- Category/ Module: ivecaseclosure
-- Root cause: already IV-E request been sent.
-- Resolution: Removed the IV-E request  by setting active flag to 0.
-- Pull request# https://source.mdthink.maryland.gov/projects/DHSCJAMS/repos/cjams_db_scripts/pull-requests/11818/overview
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select * from ivecaseclosurereview where objectid='a4c086e3-3c1b-4067-9cbf-d9b599d377fa';
select * from routing where objectid='78db32d1-62b0-41ed-af8c-79a2cecc79e7';

UPDATE cjams.routing
SET   activeflag = 0,
	updatedby = 'CDM-38637',
	updatedon = now() WHERE routingid='bd242529-33c5-4ab6-bd3c-275d4bf5dd26'
	and activeflag = 1;

	UPDATE cjams.ivecaseclosurereview
SET   activeflag = 0,
	updatedby = 'CDM-38637',
	updatedon = now() WHERE ivecaseclosurereviewid='78db32d1-62b0-41ed-af8c-79a2cecc79e7'
	and activeflag = 1;