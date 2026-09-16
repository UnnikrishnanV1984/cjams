-- CDM-17925 - CPA HOME
/*
-- Issue Description: 
	The CPA Home was never entered which has resulted in Ms Talley cannot get paid for the COVID Stipened 
	after Tiona came down with COVID in November 2020.
 
-- Add CPA Home for 7/27/2020-6/25/2021 period

-- Case ID: 2020019601823 - torie.mendes@maryland.gov
-- Client ID: 1882479 (TIONA SHAWNTRY WILLIAMS) - 1c8696e5-b538-4680-b217-41bfbb38ec73
-- Placement ID: 1559067 - 2020-07-27 To 2021-06-25 - 227aa077-29b3-4142-b4c3-14a2df83ee56
-- Private Organization: 5000744 (The Children's Guild, Inc.)	
-- CPA Office: 5001641 (Children's Guild TFC)
-- Program: 1711 (Children's Guild TFC) - 2006-07-01 To 2022-06-30

-- CPA Home: 5090380 (Zelda Tally)

-- Category/ Module: Placement (Case Management) 
-- Root cause: User error, CPA Home was selected prior to Placement Exit
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Add CPA Home
select entrydt, entrytm, exitdt, exittm, exittypecd, exitreasoncd, updatets, updateuserid 
	from placementcpahomes 
where placementid = '227aa077-29b3-4142-b4c3-14a2df83ee56'
	and activeflag = 1 ;
	

-- CPA Home: 5090380 (Zelda Tally) 	
insert into cjams.placementcpahomes
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), '227aa077-29b3-4142-b4c3-14a2df83ee56', '2020-07-27 00:00:00', '2020-07-27 08:00:00',
		'2021-06-25 00:00:00', '2021-06-25 12:00:00', 'CIPS', NULL,	'', 
		now(), 'CDM-17925', now(), 'CDM-17925', 1, 
		5090380, 1559067, NULL, NULL
	);
