/*
   Issue Description: CDM-18972
   Category/ Module  : add CPA home
   Root cause: user wants add CPA home
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

insert into cjams.placementcpahomes
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), '80ac734d-ea12-42da-9996-90990b5b0f3b', '2020-06-23 00:00:00', '2020-07-27 08:00:00',
		'2021-04-17 00:00:00', '2021-06-25 12:00:00', 'CIPS', NULL,	'', 
		now(), 'CDM-18972', now(), 'CDM-18972', 1, 
		5072193, 1558908, NULL, NULL
	);