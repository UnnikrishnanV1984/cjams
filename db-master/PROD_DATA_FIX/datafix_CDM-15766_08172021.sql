-- CDM-15766 - CPA HOME MISSING
/*
-- Issue Description: 
	The placement for Hearts and Homes - Family Ties Treatment Foster Care from 6/18/2020 - 05/21/2021 
	does not have a CPA home. The CPA home for these dates was Ms. Thelma Lovings. 
 
-- Add CPA Home
-- Case ID: 3153784
-- Client ID: 1714298 (JOHN HYMAN) - 52608a26-f1b2-406b-94f0-21644b726deb
-- Placement ID: 1556554 - 2020-06-18 To 2021-05-21 - ae6b7a9a-e653-4da1-884b-854641aa64bf
-- Private Organization: 5000788 (Hearts and Homes For Youth, Inc.)
-- CPA Office: 5000800 (Hearts and Homes - Family Ties Treatment Foster Care)
-- Program: 1336 (Family Ties Treatment Foster Care Hearts & Homes) - 2006-07-01 To 2022-06-30
-- CPA Home: 5032304 (Thelma  Lovings) - 2020-06-18 To 2021-05-21	

-- Category/ Module: Placement (Case Management) 
-- Root cause: User error, CPA Home was selected prior to Placement Exit
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Add CPA Home
select entrydt, entrytm, exitdt, exittm, exittypecd, exitreasoncd, updatets, updateuserid 
	from placementcpahomes 
where placementid = 'ae6b7a9a-e653-4da1-884b-854641aa64bf'
	and activeflag = 1 ;
	
-- CPA Home: 5032304 (Thelma  Lovings) - 2020-06-18 To 2021-05-21	
insert into cjams.placementcpahomes
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), 'ae6b7a9a-e653-4da1-884b-854641aa64bf', '2020-06-18 00:00:00', '2020-06-18 08:00:00', 
		'2021-05-21 00:00:00', '2021-05-21 18:00:00', 'CIPS', NULL,	'', 
		now(), 'CDM-15766', now(), 'CDM-15766', 1, 
		5032304, 1556554, NULL, NULL
	);

