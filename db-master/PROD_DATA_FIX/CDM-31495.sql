/*
   Issue Description: CDM-31495
   Category/ Module  : 
   Root cause:user want to change GAP from Marie Hil to SAMERIA MONTGOMERY
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   
-- Case ID: 3206087
-- Client ID: 3278194 ( SHAMERIA MONTGOMERY) - fff04a70-31a6-4597-b549-1fd55845e749
-- Provider ID: 5065778	(Shaheed Montgomery)
-- GAP ID: 2985 - 2013-10-24 To 2023-10-22 - 7f4eedb2-7ddc-4657-a3e1-3d7e67707a09
*/ 

-- To Trigger Under Over batch for generating the missing April 2023 payment (CDM-31495)
select ratestartdate, rateenddate, approvalstatustypekey, approvaldate, updatedby, updatedon
	from cjams.gapratesrevision
where gaprateid = '2f5699f4-3740-450b-8d14-778dd0a71dee' ;

update cjams.gapratesrevision
set approvaldate = now(),
	updatedby = 'CDM-31495',
	updatedon = now()
where gaprateid = '2f5699f4-3740-450b-8d14-778dd0a71dee' ;


-- Commented, this fix is Not required. This was a user error, 
-- they changed the client name from child to parent, Shameria Montgomery's profile has been changed to Marie Hill on 04/04/2023
-- which is reverted now in production
 
/*
update personprogramarea set activeflag=1 , personid='ce616100-580e-4576-85e0-97426999edc1' where  personprogramid ='71b7acf9-f974-42b9-921a-8056f620dec4';

update permanencyplan set activeflag=0,updatedby = 'CDM-31495',updatedon = now() where permanencyplanid in (
'84e39a65-c8e2-421f-a75f-f13a99ee74fe',
'38c7307a-9d99-472d-a384-ec67232524f8',
'c725c6c1-6cdf-4740-a99e-e9a0c225524c');

update permanencyplan set intakeservicerequestactorid='c7914177-9f93-4cc1-a61a-9e71ae02c5d0',updatedby = 'CDM-31495' ,updatedon = now() where permanencyplanid='2d2e3f97-c0c4-467c-b196-fd8dfa144f7f';
*/