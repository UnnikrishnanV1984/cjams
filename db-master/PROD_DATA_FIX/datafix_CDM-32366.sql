/*
 * CDM-32366 - incorrect supervisor name
 * Customer Email ID:shalynn.chandler@maryland.gov
 * Dashboard:This case is due to close. Under updated by it should read Sharon Ledbetter not Ashley argyle. 
 * Screen URL: https://cw.cjams.mdthink.maryland.gov/#/pages/contact-support
 * TO DO: Case # 231030118664 / Assessments / CANS-F Updated By name is showing wrongly as Argyle, Ashley. The User Name should be Sharon Ledbetter.
 */

--select insertedby, updatedby,* from assessment where assessmentid='061d601f-6a58-4981-89da-ea20940bf2c8';
--select * from userprofile where securityusersid in ('caf1e210-21af-4ab4-87d9-bab9847a0eaf', 'd89df45b-9f7b-4334-b8a5-d21598d6dd56');
--select * from userprofile where displayname='Sharon Ledbetter'; -- c6bae00e-e715-4b79-9b70-cc185874738f

UPDATE cjams.assessment
SET updatedby='c6bae00e-e715-4b79-9b70-cc185874738f', updatedon=now() 
WHERE assessmentid='061d601f-6a58-4981-89da-ea20940bf2c8';