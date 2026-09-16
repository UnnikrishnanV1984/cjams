-- CDM-41820 - AFCARS CPA Datafix
/*
-- Issue Description: 
    User request to add CPA home on the closed Placement
	
-- Category/ Module: Placement (Case Management) 
-- Root cause: User Error (case worker did not updated the CPS Home Info prior to placement exit) 
-- Fix Provided: Datafix has been promoted to add the requested CPA Home entry.
-- Regression Impacts: N/A
-- Is Code fix Required?: N/A
-- Code fix ticket#: (If Yes)
-- Reason why no related code fix: User Error. 
*/	

-- AFCARS CPA Homes Data cleanup (CDM-41820)

-- Delete before Insert
delete from cjams.placementcpahomes where createuserid = 'CDM-41820' ;

-- Frederick
-- Case 	Client	Entry 		exit	   Placement 	
-- 3301857	3908431 6/8/2023	8/2/2023   1771995
-- 6013553	Oluwaremilekun Aiyela 	CPA Home 
insert into cjams.placementcpahomes
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), '8c81e055-924b-4faf-a4ca-328952d77e8f', '2023-06-08 00:00:00', '2023-06-08 16:31:00', 
		'2023-08-02 00:00:00', '2023-08-02 11:59:00', 'CIPS', NULL, '', 
		now(), 'CDM-41820', now(), 'CDM-41820', 1, 
		6013553, 1771995, NULL, NULL
	);
	
	
-- Charles
-- Case 	Client	Entry 		exit	   Placement 	
-- 3210386	3291944 7/1/2021	7/14/2021	1564439
-- 5081353	Tamara Scott	CPA Home - 7/1/2021	2:00 PM	7/14/2021	3:00 PM
insert into cjams.placementcpahomes
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), '460d74b3-805d-466f-a635-4b9fb95e3717', '2021-07-01 00:00:00', '2021-07-01 14:00:00', 
		'2021-07-14 00:00:00', '2021-07-14 15:00:00', 'CIP', 'CIPRA', '', 
		now(), 'CDM-41820', now(), 'CDM-41820', 1, 
		5081353, 1564439, NULL, NULL
	);


-- 3210386		3291944 2/28/2024	3/19/2024   1871051
-- 6104404	Kaitlyn Ewoldt 	CPA Home 2/28/2024	2:06 PM	3/19/2024	3:18 PM
insert into cjams.placementcpahomes
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), '165abef4-fbc4-4e34-b577-a48e57076dba', '2024-02-28 00:00:00', '2024-02-28 14:06:00', 
		'2024-03-19 00:00:00', '2024-03-19 15:18:00', 'CIPS', NULL, '', 
		now(), 'CDM-41820', now(), 'CDM-41820', 1, 
		6104404, 1871051, NULL, NULL
	);

-- Anne Arundel
-- Case 		Client		Entry 		exit	   Placement 	
-- 221030016272	200913286	6/21/2023	11/3/2023	1687528
-- 6049482	Eleanor Miles 	CPA Home 06/21/2023	12:00 PM	11/3/2023	10:00 AM
insert into cjams.placementcpahomes
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), '19c3b9fb-2a02-475b-89f1-a86d1b2ca616', '2023-06-21 00:00:00', '2023-06-21 12:00:00', 
		'2023-11-03 00:00:00', '2023-11-03 10:00:00', 'CIPS', NULL, '', 
		now(), 'CDM-41820', now(), 'CDM-41820', 1, 
		6049482, 1687528, NULL, NULL
	);


-- 221030016381	200910230	7/13/2022	9/30/2022	1573310
-- 6005918	Tanya Freeman 	CPA Home 7/13/2022	4:00 PM	9/30/2022	1:00 PM
insert into cjams.placementcpahomes
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), '96ea0361-e885-4ea0-8c6d-83a91128e8dd', '2022-07-13 00:00:00', '2022-07-13 16:00:00', 
		'2022-09-30 00:00:00', '2022-09-30 13:00:00', 'CIP', 'CIPB', '', 
		now(), 'CDM-41820', now(), 'CDM-41820', 1, 
		6005918, 1573310, NULL, NULL
	);

-- 221030016381	200910231	7/13/2022	9/12/2022	1573308
-- 6005918	Tanya Freeman 	CPA Home 7/13/2022	4:00 PM	9/12/2022	11:00 AM
insert into cjams.placementcpahomes
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), '371075ab-4234-47b4-b659-8b06cbe8fcfc', '2022-07-13 00:00:00', '2022-07-13 16:00:00', 
		'2022-09-12 00:00:00', '2022-09-12 11:00:00', 'CIP', 'CIPSAGG', '', 
		now(), 'CDM-41820', now(), 'CDM-41820', 1, 
		6005918, 1573308, NULL, NULL
	);
	
-- Allegany
-- Case 	Client	Entry 		exit	   Placement 	
-- 3226439		3548461	11/10/2022	2/6/2023	1576033
-- 5068772	Tashima Thornton 	CPA Home	11/10/2022	11:00 AM	2/6/2023	5:00 PM
insert into cjams.placementcpahomes
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), 'ed5bb32e-a10d-450b-bc7d-8916ebcc6ba7', '2022-11-10 00:00:00', '2022-11-10 11:00:00', 
		'2023-02-06 00:00:00', '2023-02-06 17:00:00', 'CIPS', NULL, '', 
		now(), 'CDM-41820', now(), 'CDM-41820', 1, 
		5068772, 1576033, NULL, NULL
	);
	
-- 3266527		2997109	5/29/2020	8/17/2020	1447580
-- 5093877	April Dawson 	CPA Home	05/29/2020	3:00 PM	08/17/2020	7:16 PM
insert into cjams.placementcpahomes
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), 'd7058b4b-1e9a-426c-9388-a2936d382a84', '2020-05-29 00:00:00', '2020-05-29 15:00:00', 
		'2020-08-17 00:00:00', '2020-08-17 19:16:00', 'CIPS', NULL, '', 
		now(), 'CDM-41820', now(), 'CDM-41820', 1, 
		5093877, 1447580, NULL, NULL
	);


-- Washington
-- Case 		Client		Entry 		exit	    Placement 	
-- 202008501091	9970184		8/15/2023	3/22/2024	1721929
-- 6056766	8/15/23	2:45 PM	3/22/24	1:30 PM
insert into cjams.placementcpahomes
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), 'e89c6722-1a8c-4326-8911-e2f02bf2c2d1', '2023-08-15 00:00:00', '2023-08-15 14:45:00', 
		'2024-03-22 00:00:00', '2024-03-22 13:30:00', 'CIP', 'CIPI', '', 
		now(), 'CDM-41820', now(), 'CDM-41820', 1, 
		6056766, 1721929, NULL, NULL
	);
	
-- 202008501091	200005699	8/15/2023	3/22/2024	1721962
-- 6056766	8/15/23	2:45 PM	3/22/24	1:30 PM
insert into cjams.placementcpahomes
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), 'f0e906aa-a940-472e-9fff-2c85a3632a71', '2023-08-15 00:00:00', '2023-08-15 14:45:00', 
		'2024-03-22 00:00:00', '2024-03-22 13:30:00', 'CIP', 'CIPI', '', 
		now(), 'CDM-41820', now(), 'CDM-41820', 1, 
		6056766, 1721962, NULL, NULL
	);
	
-- 221030015476	4413485		2/1/2024	5/31/2024	1828629
-- 5096740	2/1/2024	3:00 PM	05/31/24	8:01 AM
insert into cjams.placementcpahomes
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), '90255c90-8776-434b-8209-c01c4a7217a4', '2024-02-01 00:00:00', '2024-02-01 09:02:00', 
		'2024-05-31 00:00:00', '2024-05-31 11:00:00', 'CIP', 'CIPPRCRS', '', 
		now(), 'CDM-41820', now(), 'CDM-41820', 1, 
		5096740, 1828629, NULL, NULL
	);
	
-- 3152578			2399015		6/2/2023	2/13/2024	1675245
-- 6001858	06/02/2023	400p	02/13/2024	1200p
insert into cjams.placementcpahomes
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), 'c92ab617-487e-414b-8736-8e4cf633467f', '2023-06-02 00:00:00', '2023-06-02 16:00:00', 
		'2024-02-13 00:00:00', '2024-02-13 12:00:00', 'CIPS', NULL, '', 
		now(), 'CDM-41820', now(), 'CDM-41820', 1, 
		6001858, 1675245, NULL, NULL
	);

-- 3178387			200295801	12/1/2023	4/19/2024	1804376
-- 6021541	12/1/23	11:00 AM	4/19/24	7:00 AM
insert into cjams.placementcpahomes
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), 'a0211199-fb8c-41bd-b322-d6fb0e49afb0', '2023-12-01 00:00:00', '2023-12-01 11:00:00', 
		'2024-04-19 00:00:00', '2024-04-19 07:00:00', 'CIP', 'CIPPWR', '', 
		now(), 'CDM-41820', now(), 'CDM-41820', 1, 
		6021541, 1804376, NULL, NULL
	);
	
-- 3257869			3755315		11/29/2023	2/15/2024	1783065
-- 6090753	11/29/23	11:00 AM	2/15/24	1:00 PM
insert into cjams.placementcpahomes
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), '382c2bae-0a80-46d9-996f-030dfd6037d3', '2023-11-29 00:00:00', '2023-11-29 11:00:00', 
		'2024-02-15 00:00:00', '2024-02-15 13:00:00', 'CIP', 'CIPPCTH', '', 
		now(), 'CDM-41820', now(), 'CDM-41820', 1, 
		6090753, 1783065, NULL, NULL
	);
	
-- 3257869			3755315		2/15/2024	6/11/2024	1830977
-- 6005050	2/15/24	5:15 PM	6/11/24	5:00 PM
insert into cjams.placementcpahomes
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), 'ae6e5471-09a4-4752-b8eb-c15775cc206b', '2024-02-15 00:00:00', '2024-02-15 17:15:00', 
		'2024-06-11 00:00:00', '2024-06-11 17:00:00', 'CIPS', NULL, '', 
		now(), 'CDM-41820', now(), 'CDM-41820', 1, 
		6005050, 1830977, NULL, NULL
	);
	
-- 3257869			3856189		11/29/2023	2/15/2024	1783098
-- 6090753	11/29/23	11:00 AM	2/15/24	1:00 PM
insert into cjams.placementcpahomes
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), 'ac347f6d-c439-44c9-afcd-b85fedf85467', '2023-11-29 00:00:00', '2023-11-29 11:00:00', 
		'2024-02-15 00:00:00', '2024-02-15 13:00:00', 'CIP', 'CIPPCTH', '', 
		now(), 'CDM-41820', now(), 'CDM-41820', 1, 
		6090753, 1783098, NULL, NULL
	);
	
-- 3257869			3856189		2/15/2024	6/11/2024	1830978
-- 6005050	2/15/24	5:15 PM	6/11/24	5:00 PM
insert into cjams.placementcpahomes
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), 'bf4c7529-1c2d-452f-9d80-6fb269e43e85', '2024-02-15 00:00:00', '2024-02-15 17:15:00', 
		'2024-06-11 00:00:00', '2024-06-11 17:00:00', 'CIPS', NULL, '', 
		now(), 'CDM-41820', now(), 'CDM-41820', 1, 
		6005050, 1830978, NULL, NULL
	);
	
-- 3281189			4147209		3/2/2023	4/7/2023	1627684
-- 6007687	03/02/2023	230p	04/07/24	400p
insert into cjams.placementcpahomes
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), '7564df23-a402-4168-8464-1be6e83c9911', '2023-03-02 00:00:00', '2023-03-02 14:30:00', 
		'2023-04-07 00:00:00', '2023-04-07 16:00:00', 'CIP', 'CIPTWV', '', 
		now(), 'CDM-41820', now(), 'CDM-41820', 1, 
		6007687, 1627684, NULL, NULL
	);
	
-- 3192093			3569747		2/1/2024	7/8/2024	1827091
-- 5092709	2/1/24	10:00 AM	7/8/24	10:00 AM
insert into cjams.placementcpahomes
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), 'c4b1c959-2c2c-45cc-86f7-9b633da6a7a3', '2024-02-01 00:00:00', '2024-02-01 10:00:00', 
		'2024-07-08 00:00:00', '2024-07-08 10:00:00', 'CIP', 'CIPO', '', 
		now(), 'CDM-41820', now(), 'CDM-41820', 1, 
		5092709, 1827091, NULL, NULL
	);

-- Montgomery
-- Case 	Client			Entry 		exit	   Placement 	
-- 211030012985	200845652	12/13/2021	12/16/2021	1568783	
-- 5069061	12/13/2021	7:00 PM	12/16/2021	1:00 PM
insert into cjams.placementcpahomes
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), '802435ac-ef53-417e-8c64-5bf33a46d644', '2021-12-13 00:00:00', '2021-12-13 19:00:00', 
		'2021-12-16 00:00:00', '2021-12-16 13:00:00', 'CIP', 'CIPO', '', 
		now(), 'CDM-41820', now(), 'CDM-41820', 1, 
		5069061, 1568783, NULL, NULL
	);	
	

	
-- 211030012985	200845651	12/13/2021	12/16/2021	1568784	
-- 5069061	12/13/2021	7:00 PM	12/16/2021	1:00 PM
insert into cjams.placementcpahomes
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), 'a6fbdced-e834-4590-bb6a-793e43d8d17d', '2021-12-13 00:00:00', '2021-12-13 19:00:00', 
		'2021-12-16 00:00:00', '2021-12-16 13:00:00', 'CIP', 'CIPO', '', 
		now(), 'CDM-41820', now(), 'CDM-41820', 1, 
		5069061, 1568784, NULL, NULL
	);	
	
-- 3282747	3893940	5/4/2022	6/21/2022	1571845	
-- 6005918	5/4/2022	7:30 PM	6/21/2022	6:00 PM
insert into cjams.placementcpahomes
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), 'eb225947-74f8-4d4e-af8e-1ad6d3d18c52', '2022-05-04 00:00:00', '2022-05-04 19:30:00', 
		'2022-06-21 00:00:00', '2022-06-21 17:00:00', 'CIP', 'CIPB', '', 
		now(), 'CDM-41820', now(), 'CDM-41820', 1, 
		6005918, 1571845, NULL, NULL
	);	
	
-- 3279366	4108811	2/26/2024	2/28/2024	1838806	
-- 6013156	2/26/24	8:00 AM	2/28/24	5:00 PM
insert into cjams.placementcpahomes
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), 'b5894060-236f-47d4-a703-fc66e7f57112', '2024-02-26 00:00:00', '2024-02-26 08:00:00', 
		'2024-02-28 00:00:00', '2024-02-28 17:00:00', 'CIP', 'CIPNHC', '', 
		now(), 'CDM-41820', now(), 'CDM-41820', 1, 
		6013156, 1838806, NULL, NULL
	);	
	
-- 3279366	4108811	2/28/2024	3/4/2024	1841108	
-- 5071352	2/28/2024	5:00 PM	3/4/2024	7:00 PM
insert into cjams.placementcpahomes
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), '1fdb1f2a-a823-4a28-8e9d-c51e6fbb93c1', '2024-02-28 00:00:00', '2024-02-28 19:00:00', 
		'2024-03-04 00:00:00', '2024-03-04 19:00:00', 'CIP', 'CIPNHC', '', 
		now(), 'CDM-41820', now(), 'CDM-41820', 1, 
		5071352, 1841108, NULL, NULL
	);	
	
-- 3190357	200175992	9/2/2022	10/13/2022	1574564	
-- 5023201	9/2/2022	4:00 PM	10/13/22	9:00 AM
insert into cjams.placementcpahomes
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), '7bdb4252-38b5-4e3a-b4b8-9c087dc26341', '2022-09-02 00:00:00', '2022-09-02 16:00:00', 
		'2022-10-13 00:00:00', '2022-10-13 09:00:00', 'CIP', 'CIPNHC', '', 
		now(), 'CDM-41820', now(), 'CDM-41820', 1, 
		5023201, 1574564, NULL, NULL
	);	
	
-- 3256621	3269004	4/7/2020	9/25/2020	340204	
-- 5094430	4/7/20	2:00 PM	9/25/20	3:00 PM
insert into cjams.placementcpahomes
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), '0509a534-3834-4ee4-8f8b-838addaf2a53', '2020-04-07 00:00:00', '2020-04-07 14:00:00', 
		'2020-09-25 00:00:00', '2020-09-25 15:00:00', 'CIP', 'CIPNMS','', 
		now(), 'CDM-41820', now(), 'CDM-41820', 1, 
		5094430, 340204, NULL, NULL
	);	
	
-- 3293281	4093837	1/31/2019	8/19/2019	333673	
-- 5033971	1/31/2019	10:00 AM	8/19/2019	10:00 AM
insert into cjams.placementcpahomes
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), 'a4134100-be81-4e03-b2f2-f4554015ac75', '2019-01-31 00:00:00', '2019-01-31 10:00:00', 
		'2019-08-19 00:00:00', '2019-08-19 10:00:00', 'CIP', 'CISR', '', 
		now(), 'CDM-41820', now(), 'CDM-41820', 1, 
		5033971, 333673, NULL, NULL
	);	
	
-- 3293281	4093837	11/15/2023	1/19/2024	1778392	
-- 6004265	11/15/2023	4:45 PM	1/19/2024	1:47 PM
insert into cjams.placementcpahomes
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), '2a819826-173e-4b06-a863-fd3f6a49957b', '2023-11-15 00:00:00', '2023-11-15 16:45:00', 
		'2024-01-19 00:00:00', '2024-01-19 13:47:00', 'CIP', 'CIPPRCRS', '', 
		now(), 'CDM-41820', now(), 'CDM-41820', 1, 
		6004265, 1778392, NULL, NULL
	);	
	
-- CDM-40205
-- 3293281	4093836	2/26/2024	6/6/2024	1841442	
-- 5084027	2/26/2024	9:01 AM	6/6/2024	5:00 PM
-- df8bead4-eb6a-487e-841b-f900301363fd	2024-02-26 00:00:00	2024-06-06 00:00:00	09:01	17:00	CIPS

-- 211030012592	200811447	10/5/2023	12/20/2023	1805768	
-- 6013553	10/5/23	5:00 PM	12/20/23	5:00 PM
insert into cjams.placementcpahomes
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), '9d6433bb-0e65-48cb-bd96-fababd09f329', '2023-10-05 00:00:00', '2023-10-05 17:00:00', 
		'2023-12-20 00:00:00', '2023-12-20 17:00:00', 'CIP', 'CIPO', '', 
		now(), 'CDM-41820', now(), 'CDM-41820', 1, 
		6013553, 1805768, NULL, NULL
	);	
	
-- 221030016856	200852643	1/31/2024	3/6/2024	1826160	
-- 5091015	1/31/24	10:00 AM	3/6/24	9:00 AM
insert into cjams.placementcpahomes
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), 'b86fd3f9-759b-49db-9e76-5efec00edeb4', '2024-01-31 00:00:00', '2024-01-31 10:00:00', 
		'2024-03-06 00:00:00', '2024-03-06 09:00:00', 'CIP', 'CIPO', '', 
		now(), 'CDM-41820', now(), 'CDM-41820', 1, 
		5091015, 1826160, NULL, NULL
	);	
	
-- 3193098	3127840	3/14/2019	7/18/2019	333943	
-- 5091015	3/14/2019	1:00 PM	7/18/2019	3:30 PM
insert into cjams.placementcpahomes
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), 'd81aab49-9078-46c2-b5ab-376c59dd0426', '2019-03-14 00:00:00', '2019-03-14 13:00:00', 
		'2019-07-18 00:00:00', '2019-07-18 15:30:00', 'CIP', 'CIDP', '', 
		now(), 'CDM-41820', now(), 'CDM-41820', 1, 
		5091015, 333943, NULL, NULL
	);	
	
-- 3280018	3798973	8/10/2021	9/3/2021	1565729	
-- 5062853	8/10/21	10:00 AM	9/3/21	10:00 AM
insert into cjams.placementcpahomes
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), '6a0867d8-babe-4b28-9f3e-41e9495e2032', '2021-08-10 00:00:00', '2021-08-10 10:00:00', 
		'2021-09-03 00:00:00', '2021-09-03 10:00:00', 'CIP', 'CIPPWS', '', 
		now(), 'CDM-41820', now(), 'CDM-41820', 1, 
		5062853, 1565729, NULL, NULL
	);	
	
-- 3280018	3798973	9/3/2021	2/7/2022	1566172	
-- 6003613	9/3/21	10:00 AM	2/7/22	9:30 AM
insert into cjams.placementcpahomes
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), 'df3cff51-a114-4216-ad70-ec92638456a2', '2021-09-03 00:00:00', '2021-09-03 10:00:00', 
		'2022-02-07 00:00:00', '2022-02-07 09:30:00', 'CIP', 'CIPB', '', 
		now(), 'CDM-41820', now(), 'CDM-41820', 1, 
		6003613, 1566172, NULL, NULL
	);	
	
-- 3280018	3798974	9/3/2021	1/27/2022	1566175	
-- 6003613	9/3/21	12:00 PM	1/27/22	9:00 AM
insert into cjams.placementcpahomes
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), '4291e521-e6fd-4836-8238-33a81aac1bf7', '2021-09-03 00:00:00', '2021-09-03 12:00:00', 
		'2022-01-27 00:00:00', '2022-01-27 09:00:00', 'CIP', 'CIPRA', '', 
		now(), 'CDM-41820', now(), 'CDM-41820', 1, 
		6003613, 1566175, NULL, NULL
	);	
	
-- 3290109	4243213	8/12/2020	10/6/2020	1556952	
-- 5067048	8/12/2020	11:00 AM	10/6/2020	9:00 AM
insert into cjams.placementcpahomes
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), '484cea9d-0dba-49d8-939f-d508c433cfd5', '2020-08-12 00:00:00', '2020-08-12 11:00:00', 
		'2020-10-06 00:00:00', '2020-10-06 09:00:00', 'CIPS', NULL, '', 
		now(), 'CDM-41820', now(), 'CDM-41820', 1, 
		5067048, 1556952, NULL, NULL
	);	
	
-- 3290109	4243213	9/24/2021	1/6/2022	1566878	
-- 5090576	9/24/21	8:00 AM	1/6/22	5:30 PM
insert into cjams.placementcpahomes
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), '6e659b4d-fd75-4668-b50a-eb0ad602a7dc', '2021-09-24 00:00:00', '2021-09-24 08:00:00', 
		'2022-01-06 00:00:00', '2022-01-06 17:30:00', 'CIP', 'CIPDWP', '', 
		now(), 'CDM-41820', now(), 'CDM-41820', 1, 
		5090576, 1566878, NULL, NULL
	);	
	
-- 3294321	3731043	5/7/2019	7/23/2019	335115	
-- 5092905	05/07/2019	4:00 PM	07/23/2019	11:30 AM
insert into cjams.placementcpahomes
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), 'fb2f5cdd-7266-4b96-ae56-c1c8a6690d05', '2019-05-07 00:00:00', '2019-05-07 16:00:00', 
		'2019-07-23 00:00:00', '2019-07-23 11:30:00', 'CIP', 'CIPDA', '', 
		now(), 'CDM-41820', now(), 'CDM-41820', 1, 
		5092905, 335115, NULL, NULL
	);	
	
-- 3294321	3731043	7/23/2019	8/7/2019	335942	
-- 5090712	7/23/2019	10:00 AM	8/7/2019	10:00 AM
insert into cjams.placementcpahomes
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), 'e0ef4c33-b180-4ed5-8a78-1bf47196b801', '2019-07-23 00:00:00', '2019-07-23 10:00:00', 
		'2019-08-07 00:00:00', '2019-08-07 10:00:00', 'CIP', 'CINC', '', 
		now(), 'CDM-41820', now(), 'CDM-41820', 1, 
		5090712, 335942, NULL, NULL
	);	
	

-- 3305549	4459849	1/2/2022	3/25/2022	1569044	
-- 5023972	1/2/2022	12:00 PM	3/25/2022	9:00 AM
insert into cjams.placementcpahomes
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), '48590ded-f85a-41d5-b7cf-4d3db1ea5ad0', '2022-01-02 00:00:00', '2022-01-02 12:00:00', 
		'2022-03-25 00:00:00', '2022-03-25 09:00:00', 'CIPS', NULL, '', 
		now(), 'CDM-41820', now(), 'CDM-41820', 1, 
		5023972, 1569044, NULL, NULL
	);	
	
-- 3232138	3580253	11/13/2022	12/7/2022	1576155	
-- 5023972	11/13/2022	11:00 PM	12/7/2022	5:00 PM
insert into cjams.placementcpahomes
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), '1456a99d-05a3-43e9-ae96-3c425329289d', '2022-11-13 00:00:00', '2022-11-13 23:00:00', 
		'2022-12-07 00:00:00', '2022-12-07 17:00:00', 'CIPS', NULL, '', 
		now(), 'CDM-41820', now(), 'CDM-41820', 1, 
		5023972, 1576155, NULL, NULL
	);	
	
-- 3286206	3809784	4/22/2019	6/25/2019	334236	
-- 5062358	4/22/19	3:00 PM	6/25/19	11:11 Am
insert into cjams.placementcpahomes
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), '1a0c0ff7-e5d6-46f3-bd8f-a1129bf6015b', '2019-04-22 00:00:00', '2019-04-22 15:00:00', 
		'2019-06-25 00:00:00', '2019-06-25 11:11:00', 'CIPS', NULL, '', 
		now(), 'CDM-41820', now(), 'CDM-41820', 1, 
		5062358, 334236, NULL, NULL
	);	
	
-- 3290328	4260366	7/22/2021	11/30/2021	1564951	
-- 5096763	7/22/21	10:00 AM	11/30/21	5:00 PM
insert into cjams.placementcpahomes
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), '46e6334a-a3d7-452e-ad09-58402b774ead', '2021-07-22 00:00:00', '2021-07-22 10:00:00', 
		'2021-11-30 00:00:00', '2021-11-30 17:00:00', 'CIP', 'CIPRA', '', 
		now(), 'CDM-41820', now(), 'CDM-41820', 1, 
		5096763, 1564951, NULL, NULL
	);	
	
-- 3301408	4224239	10/13/2020	1/6/2021	1558453	
-- 5094433	10/13/20	5:00 PM		12/3/20		9:00 PM
insert into cjams.placementcpahomes
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), 'ca42167e-6a0e-4e05-bf23-5d6bf4c61748', '2020-10-13 00:00:00', '2020-10-13 17:00:00', 
		'2020-12-03 00:00:00', '2020-12-03 21:00:00', 'CIPS', NULL, '', 
		now(), 'CDM-41820', now(), 'CDM-41820', 1, 
		5094433, 1558453, NULL, NULL
	);	
	
-- 5071352	12/3/20		9:30 PM		12/21/20	11:00 AM
insert into cjams.placementcpahomes
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), 'ca42167e-6a0e-4e05-bf23-5d6bf4c61748', '2020-12-03 00:00:00', '2020-12-03 21:30:00', 
		'2020-12-21 00:00:00', '2020-12-21 23:00:00', 'CIPS', NULL, '', 
		now(), 'CDM-41820', now(), 'CDM-41820', 1, 
		5071352, 1558453, NULL, NULL
	);	
	
-- 5089666	12/21/20	12:00 PM	1/6/21		11:30 AM
insert into cjams.placementcpahomes
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), 'ca42167e-6a0e-4e05-bf23-5d6bf4c61748', '2020-12-21 23:00:00', '2020-12-21 24:00:00', 
		'2021-01-06 00:00:00', '2021-01-06 11:30:00', 'CIPS', NULL, '', 
		now(), 'CDM-41820', now(), 'CDM-41820', 1, 
		5089666, 1558453, NULL, NULL
	);	


-- 3022613	2220711	3/14/2019	4/26/2019	334046	
-- 5075572	3/14/2019	5:00 PM	3/22/2019	5:00 PM
insert into cjams.placementcpahomes
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), '17035dd6-0b28-4cef-a103-a2596401e187', '2019-03-14 00:00:00', '2019-03-14 17:00:00', 
		'2019-03-22 00:00:00', '2019-03-22 17:00:00', 'CIP', 'CIPDA', '', 
		now(), 'CDM-41820', now(), 'CDM-41820', 1, 
		5075572, 334046, NULL, NULL
	);	
	
-- 5090432	3/22/2019	9:00 AM	4/26/2019	5:00 PM
insert into cjams.placementcpahomes
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), '17035dd6-0b28-4cef-a103-a2596401e187', '2019-03-22 00:00:00', '2019-03-22 17:01:00', 
		'2019-04-26 00:00:00', '2019-04-26 17:00:00', 'CIP', 'CIPDA', '', 
		now(), 'CDM-41820', now(), 'CDM-41820', 1, 
		5090432, 334046, NULL, NULL
	);	


-- 2020026803210	200021638	10/23/2023	2/26/2024	1762596	
-- 05af14ea-0ad3-4b69-8e79-2ca5dc1cf681	2023-10-23 00:00:00	2024-02-26 00:00:00	13:30	15:00	CIP	CIPO
insert into cjams.placementcpahomes
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), '05af14ea-0ad3-4b69-8e79-2ca5dc1cf681', '2023-10-23 00:00:00', '2023-10-23 13:30:00', 
		'2024-02-26 00:00:00', '2024-02-26 15:00:00', 'CIP', 'CIPO', '', 
		now(), 'CDM-41820', now(), 'CDM-41820', 1, 
		6005070, 1762596, NULL, NULL
	);	

-- 6005070	2/26/2024	3:05 PM	08/01/2024	9:00 AM
insert into cjams.placementcpahomes
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), '05af14ea-0ad3-4b69-8e79-2ca5dc1cf681', '2024-02-26 00:00:00', '2024-02-26 15:05:00', 
		'2024-08-01 00:00:00', '2024-08-01 09:00:00', 'CIP', 'CIPO', '', 
		now(), 'CDM-41820', now(), 'CDM-41820', 1, 
		6005070, 1762596, NULL, NULL
	);	

-- 3295623	4391542	12/23/2021	3/2/2022	1569230	
-- 6007687	12/23/21	5:00 PM	3/2/22	11:30 AM
insert into cjams.placementcpahomes
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), 'a264c796-f772-4729-a271-b61c2df08faf', '2021-12-23 00:00:00', '2021-12-23 17:00:00', 
		'2022-03-02 00:00:00', '2022-03-02 11:30:00', 'CIPS', NULL, '', 
		now(), 'CDM-41820', now(), 'CDM-41820', 1, 
		6007687, 1569230, NULL, NULL
	);	
	
	
-- Howard
-- Case 	 Client		Entry 		exit	   Placement 	
-- 202100805266 200304063	5/13/2022	10/1/2022	1572509
-- 6005611	Shelley Richardson 	CPA Home	5/13/2022	12:30 PM	10/1/2022	8:00 AM
insert into cjams.placementcpahomes
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), 'ab025429-408b-49f7-bb91-9aa034f87bcc', '2022-05-13 00:00:00', '2022-05-13 12:30:00', 
		'2022-10-01 00:00:00', '2022-10-01 08:00:00', 'CIPS', NULL, '', 
		now(), 'CDM-41820', now(), 'CDM-41820', 1, 
		6005611, 1572509, NULL, NULL
	);

	
-- Harford
-- Case 		Client		Entry 		exit	   Placement 	
-- 231030090519	4377955		8/4/2023	8/30/2023	1735181
-- 6040263	Arnold Smith 	CPA Home	8/4/2023	9:00 AM	8/30/2023	2:00 PM
insert into cjams.placementcpahomes
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), '44cafe4f-2e75-4218-9bf7-c2cc02a2a21f', '2023-08-04 00:00:00', '2023-08-04 09:00:00', 
		'2023-08-30 00:00:00', '2023-08-30 14:00:00', 'CIPS', NULL, '', 
		now(), 'CDM-41820', now(), 'CDM-41820', 1, 
		6040263, 1735181, NULL, NULL
	);

-- 231030127620	4094513		11/17/2023	12/11/2023	1793350
-- 6007843	Tanya Sherrod 	CPA Home	11/17/2023	2:00 PM	12/11/2023	12:00 PM
insert into cjams.placementcpahomes
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), 'c81e32e6-1586-469c-a161-9e9d1580ed31', '2023-11-17 00:00:00', '2023-11-17 14:00:00', 
		'2023-12-11 00:00:00', '2023-12-11 12:00:00', 'CIP', 'CIPPRCRS', '', 
		now(), 'CDM-41820', now(), 'CDM-41820', 1, 
		6007843, 1793350, NULL, NULL
	);

-- 231030180864	201191367	10/20/2023	3/13/2024	1769972
-- 5084668	Cynthia Brown 	CPA Home	10/20/2023	11:00 AM	3/13/2024	7:00 PM
insert into cjams.placementcpahomes
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), '3f1fd338-a4f7-446e-9365-cd4d92de8ff3', '2023-10-20 00:00:00', '2023-10-20 11:00:00', 
		'2024-03-13 00:00:00', '2024-03-13 19:00:00', 'CIP', 'CIPB', '', 
		now(), 'CDM-41820', now(), 'CDM-41820', 1, 
		5084668, 1769972, NULL, NULL
	);

-- 3128721			1862300		7/31/2019	1/24/2020	336142
-- 5094495	Donna Valentine	CPA Home	7/31/2019	11:00 AM	1/24/2020	10:30 AM
insert into cjams.placementcpahomes
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), 'd9191282-c6f4-4f0c-b9ec-3be70266700d', '2019-07-31 00:00:00', '2019-07-31 11:00:00', 
		'2020-01-24 00:00:00', '2020-01-24 10:30:00', 'CIP', 'CISR', '', 
		now(), 'CDM-41820', now(), 'CDM-41820', 1, 
		5094495, 336142, NULL, NULL
	);

-- 3128721			1862300		1/3/2024	2/29/2024	1812409
-- 5085196	Alfredo Santiago 	CPA Home	1/3/2024	1:00 PM	2/29/2024	10:00 AM
insert into cjams.placementcpahomes
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), 'b945a618-e486-4f3b-bac4-03fdc8f76da9', '2024-01-03 00:00:00', '2024-01-03 13:00:00', 
		'2024-02-29 00:00:00', '2024-02-29 10:00:00', 'CIP', 'CIPNMS', '', 
		now(), 'CDM-41820', now(), 'CDM-41820', 1, 
		5085196, 1812409, NULL, NULL
	);

	
-- Baltimore County
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
values
	(	gen_random_uuid(), 'bb10ab7c-0649-47c2-933d-c74c7fc6dda2','2023-10-16 00:00:00','2023-10-16 12:00 PM',
		'2024-02-09 00:00:00','2024-02-09 9:30 AM','CIPS',NULL,'',
		now(),'CDM-41820',now(),'CDM-41820',1,
		5085252,1760317
	);
	
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
values
	(	gen_random_uuid(), 'd92c0386-1773-4e2b-aa36-e0b79bf1f4a4','2023-11-20 00:00:00','2023-11-20 4:00 PM','2024-02-06 00:00:00','2024-02-06 2:00 PM','CIP','CIPOR','',now(),'CDM-41820',now(),'CDM-41820',1,6002440,1800925);

insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
values
	(	gen_random_uuid(), '89eab51b-a2fb-44da-b9ad-5712b6520286','2022-10-07 00:00:00','2022-10-07 8:00 PM','2023-01-11 00:00:00','2023-01-11 9:30 AM',NULL,NULL,'',now(),'CDM-41820',now(),'CDM-41820',1,6003737,1575595);

insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
values
	(	gen_random_uuid(), 'ba58ac4a-092a-4f6b-ad92-9f9d714941e8','2024-01-02 00:00:00','2024-01-02 9:30 AM','2024-05-13 00:00:00','2024-05-13 5:00 PM','PLCC','REUNIF','',now(),'CDM-41820',now(),'CDM-41820',1,6083312,1808015);

insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
values
	(	gen_random_uuid(), 'b432a79f-55b4-466f-bd66-e17185a87c02','2021-11-23 00:00:00','2021-11-23 3:00 PM','2022-03-14 00:00:00','2022-03-14 1:00 PM','CIP','CIPNLS','',now(),'CDM-41820',now(),'CDM-41820',1,5093689,1568321);

insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
values
	(	gen_random_uuid(), 'd846130a-f921-41f0-b2d5-235d83cc1271','2022-08-30 00:00:00','2022-08-30 12:30 PM','2022-12-21 00:00:00','2022-12-21 9:00 AM','CIP','CIPIS','',now(),'CDM-41820',now(),'CDM-41820',1,6004244,1576154);

insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
values
	(	gen_random_uuid(), '4459cd6f-4b32-438f-8f10-02daa70dea0e','2024-02-22 00:00:00','2024-02-22 9:01 AM','2024-03-22 00:00:00','2024-03-22 9:00 AM','CIP','CIPIS','',now(),'CDM-41820',now(),'CDM-41820',1,6108503,1834160);

insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
values
	(	gen_random_uuid(), '371db9ce-60fe-4123-8362-6bebf537fe43','2024-02-22 00:00:00','2024-02-22 9:00 AM','2024-03-22 00:00:00','2024-03-22 9:00 AM','CIP','CIPIS','',now(),'CDM-41820',now(),'CDM-41820',1,6108503,1834159);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
values
	(	gen_random_uuid(), '8192ba81-1a4c-454b-982e-2420f60296a7','2022-01-18 00:00:00','2022-01-18 8:00 AM','2022-06-23 00:00:00','2022-06-23 5:00 PM','CIPS',NULL,'',now(),'CDM-41820',now(),'CDM-41820',1,6004449,1570264);

insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
values
	(	gen_random_uuid(), '9ea61d2b-7c41-4165-93ac-c34b82c8b605','2023-07-20 00:00:00','2023-07-20 5:00 PM','2024-03-08 00:00:00','2024-03-08 10:00 AM','PLCC','REUNIF','',now(),'CDM-41820',now(),'CDM-41820',1,6057492,1733721);

insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
values
	(	gen_random_uuid(), 'cfb2612b-3e19-4242-b3b7-444a7da4504f','2023-01-17 00:00:00','2023-01-17 3:00 PM','2023-05-01 00:00:00','2023-05-01 4:45 PM','CIP','CIPNHC','',now(),'CDM-41820',now(),'CDM-41820',1,5092962,1603281);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
values
	(	gen_random_uuid(), '0a44d7ff-250a-4ca7-938c-81e6d62ed148','2023-12-29 00:00:00','2023-12-29 9:00 AM','2024-03-25 00:00:00','2024-03-25 11:00 AM','PLCC','REUNIF','',now(),'CDM-41820',now(),'CDM-41820',1,5096021,1807751);

insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
values
	(	gen_random_uuid(), '5a8aade5-b3b9-4d37-a08f-925d052ecfc4','2023-11-06 00:00:00','2023-11-06 5:00 PM','2024-06-11 00:00:00','2024-06-11 2:30 PM','CIPS',NULL,'',now(),'CDM-41820',now(),'CDM-41820',1,6018437,1776840);

insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
values
	(	gen_random_uuid(), '560533a5-cbb3-4889-a99e-1e6404648d92','2020-03-18 00:00:00','2020-03-18 12:00 PM','2020-03-26 00:00:00','2020-03-26 12:00 PM','CIP','CIPDA','',now(),'CDM-41820',now(),'CDM-41820',1,5096238,340127);

insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
values
	(	gen_random_uuid(), '43cbe289-45e4-4e66-9362-bdad4e735da7','2023-12-29 00:00:00','2023-12-29 9:00 AM','2024-03-25 00:00:00','2024-03-25 11:00 AM','PLCC','REUNIF','',now(),'CDM-41820',now(),'CDM-41820',1,5096021,1807718);

insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
values
	(	gen_random_uuid(), '23607667-fc89-46e3-ad0e-24b2a34c12cb','2023-06-01 00:00:00','2023-06-01 9:00 AM','2023-06-16 00:00:00','2023-06-16 12:00 PM','CIP','CIPB','',now(),'CDM-41820',now(),'CDM-41820',1,6047122,1684606);

insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
values
	(	gen_random_uuid(), '8e675f34-2a9e-4ef9-a3c7-a3742d130b3c','2019-09-03 00:00:00','2019-09-03 4:30 PM','2019-11-04 00:00:00','2019-11-04 12:00 PM','CIPS',' ','',now(),'CDM-41820',now(),'CDM-41820',1,5095049,336794);

insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
values
	(	gen_random_uuid(), 'b0c46507-ff66-4011-a967-6e49d85f98f1','2019-12-06 00:00:00','2019-12-06 10:00 AM','2020-01-24 00:00:00','2020-01-24 10:00 AM','CIP','CISR','',now(),'CDM-41820',now(),'CDM-41820',1,5035593,339957);

insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
values
	(	gen_random_uuid(), 'ac88a1e0-0e25-49d7-a84d-f9ed3494cd0d','2024-03-04 00:00:00','2024-03-04 10:00 AM','2024-06-04 00:00:00','2024-06-04 1:00 PM',NULL,NULL,'',now(),'CDM-41820',now(),'CDM-41820',1,5023507,1838063);

insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
values
	(	gen_random_uuid(), 'c84cc920-726e-4214-9bb2-ea275604b93e','2024-01-10 00:00:00','2024-01-10 8:00 PM','2024-01-26 00:00:00','2024-01-26 10:00 AM','CIP','CIPDWP','',now(),'CDM-41820',now(),'CDM-41820',1,5024804,1814569);

insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
values
	(	gen_random_uuid(), '70bdab23-8757-4c17-a93b-d0ddcc35966f','2024-01-26 00:00:00','2024-01-26 8:00 AM','2024-02-02 00:00:00','2024-02-02 9:00 AM','CIP','CIPR','',now(),'CDM-41820',now(),'CDM-41820',1,5048581,1826892);

insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
values
	(	gen_random_uuid(), 'ae352b7c-950f-4e43-923d-cc585affd9b7','2021-12-08 00:00:00','2021-12-08 8:00 AM','2022-07-20 00:00:00','2022-07-20 10:00 AM','CIP','CIPNHC','',now(),'CDM-41820',now(),'CDM-41820',1,6005358,1568856);
	
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
values
	(	gen_random_uuid(), '39cd237b-cf59-4fbe-986f-7d5b35329d15','2023-11-24 00:00:00','2023-11-24 5:01 PM','2023-11-29 00:00:00','2023-11-29 12:00 PM','CIP','CIPNMS','',now(),'CDM-41820',now(),'CDM-41820',1,5035723,1828863);

insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
values
	(	gen_random_uuid(), 'f587cd20-0357-4393-9de8-743ef5be1fd0','2022-09-12 00:00:00','2022-09-12 5:00 PM','2022-12-13 00:00:00','2022-12-13 5:00 PM','CIPS',NULL,'',now(),'CDM-41820',now(),'CDM-41820',1,6003956,1575912);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
values
	(	gen_random_uuid(), '3388d3df-820f-40cb-a535-c37a2a7f5b58','2019-10-11 00:00:00','2019-10-11 10:00 AM','2019-12-18 00:00:00','2019-12-18 12:00 PM','CIPS',' ','',now(),'CDM-41820',now(),'CDM-41820',1,5095877,338038);

insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
values
	(	gen_random_uuid(), '7841fc98-6c9f-45d5-9594-b3418bb33484','2023-12-12 00:00:00','2023-12-12 8:00 AM','2024-01-31 00:00:00','2024-01-31 6:00 PM','CIPS',NULL,'',now(),'CDM-41820',now(),'CDM-41820',1,6094486,1810328);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
values
	(	gen_random_uuid(), '7841fc98-6c9f-45d5-9594-b3418bb33484','2024-01-31 00:00:00','2024-01-31 6:01 PM','2024-03-14 00:00:00','2024-03-14 9:00 AM','CIPS',NULL,'',now(),'CDM-41820',now(),'CDM-41820',1,5084926,1810328);

-- 1797717
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
values
	(	gen_random_uuid(), 'beeb4f0d-6af5-42ef-b54f-c449915f188a','2023-12-13 00:00:00','2023-12-13 3:00 PM','2023-12-15 00:00:00','2023-12-15 9:00 AM',NULL,NULL,'',now(),'CDM-41820',now(),'CDM-41820',1,6100035,1928796);

insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
values
	(	gen_random_uuid(), 'beeb4f0d-6af5-42ef-b54f-c449915f188a','2023-12-15 00:00:00','2023-12-15 9:01 AM','2024-03-27 00:00:00','2024-03-27 12:00 PM',NULL,NULL,'',now(),'CDM-41820',now(),'CDM-41820',1,6049481,1928796);
-- 1797717
	
-- Cecil
-- Case 		Client		Entry 		exit	   Placement 	
-- 202107006511	4241508		9/11/2023	12/6/2023	1752352
-- 5023507	Roselyn Coley	CPA Home	9/11/2023		12/6/2023	
insert into cjams.placementcpahomes
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), 'a72977f7-c24a-4e35-a6eb-e71d246a31b4', '2023-09-11 00:00:00', '2023-09-11 10:00:00', 
		'2023-12-06 00:00:00', '2023-12-06 10:00:00', 'CIPS', NULL, '', 
		now(), 'CDM-41820', now(), 'CDM-41820', 1, 
		5023507, 1752352, NULL, NULL
	);

-- 231030066935	202073365	11/2/2023	1/14/2024	1772558
-- 6078598	Donna Brooks-Moyd 	CPA Home	11/2/23	2:00 p.m.	1/14/24	4:00 p.m.
insert into cjams.placementcpahomes
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), '9dddd20a-55ee-4d18-82d2-973e8bfd1071', '2023-11-02 00:00:00', '2023-11-02 14:00:00', 
		'2024-01-14 00:00:00', '2024-01-14 16:00:00', 'CIP', 'CIPPWR', '', 
		now(), 'CDM-41820', now(), 'CDM-41820', 1, 
		6078598, 1772558, NULL, NULL
	);

-- 3209482			3020948		9/5/2017	9/12/2017	321201
-- 5059025	Darmay Tolliver	CPA Home	9/5/2017		9/12/2017	
insert into cjams.placementcpahomes
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), '35be1caf-51d2-4119-ba4f-dd12e3694e55', '2017-09-05 00:00:00', '2017-09-05 17:00:00', 
		'2017-09-12 00:00:00', '2017-09-12 10:00:00', 'CIPS', NULL, '', 
		now(), 'CDM-41820', now(), 'CDM-41820', 1, 
		5059025, 321201, NULL, NULL
	);

-- 3292645			2460994		9/8/2023	2/3/2024	1772723
-- 6006464	Cindy Brown 	CPA Home	9/8/2023		2/3/2024
insert into cjams.placementcpahomes
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), '75f7f774-22e8-496d-99fd-eb928538a111', '2023-09-08 00:00:00', '2023-09-08 17:00:00', 
		'2024-02-03 00:00:00', '2024-02-03 09:00:00', 'CIPS', NULL, '', 
		now(), 'CDM-41820', now(), 'CDM-41820', 1, 
		6006464, 1772723, NULL, NULL
	);


-- Baltimore City
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '4bfd293a-9f8a-4fb8-890b-4694846bceee','2024-03-25 00:00:00','2024-03-25 10:58 PM',
		'2024-03-26 00:00:00','2024-03-26 10:00 AM','CIPS',NULL,'',
		now(),'CDM-41820',now(),'CDM-41820',1,
		5041158,1849100
	);
	
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), 'fbbab042-0948-4972-8a87-dd6d21bcc754','2018-12-13 00:00:00','2018-12-13 7:30 PM','2018-12-14 00:00:00','2018-12-14 12:30 PM','CIPS','','',now(),'CDM-41820',now(),'CDM-41820',1,5069085,332071);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), 'a281424a-bc8f-49a1-bd4d-6a3ecfe7f770','2020-10-16 00:00:00','2020-10-16 3:30 PM','2020-11-16 00:00:00','2020-11-16 10:00 AM',NULL,NULL,'',now(),'CDM-41820',now(),'CDM-41820',1,5087168,1558397);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '653b2d6f-c461-44c3-8192-9b9fded12104','2021-01-08 00:00:00','2021-01-08 8:00 AM','2021-02-17 00:00:00','2021-02-17 09:00','CIP','CIPB','',now(),'CDM-41820',now(),'CDM-41820',1,5095935,1560135);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '1494b993-5725-4eaf-a7fe-886a5000d92c','2024-03-18 00:00:00','2024-03-18 15:00','2024-04-05 00:00:00','2024-04-05 20:00','CIP','CIPPWS','',now(),'CDM-41820',now(),'CDM-41820',1,6005986,1845687);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '120b7e67-31ea-46d6-8447-b7eb97a41aee','2024-02-09 00:00:00','2024-02-09 15:00','2024-03-13 00:00:00','2024-03-13 14:30','PLCC','CORHADR','',now(),'CDM-41820',now(),'CDM-41820',1,5085252,1828029);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '7fd67fec-f360-48b4-a581-fdb139657eac','2023-08-16 00:00:00','2023-08-16 17:00','2023-08-21 00:00:00','2023-08-21 11:00','CIPS',NULL,'',now(),'CDM-41820',now(),'CDM-41820',1,5096021,1722888);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '3ac12660-9a17-4995-a883-c6a8e53af3b7','2023-01-05 00:00:00','2023-01-05 08:00','2023-01-10 00:00:00','2023-01-10 10:00','CIPS',NULL,'',now(),'CDM-41820',now(),'CDM-41820',1,6006689,1606670);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '1b61649a-a172-49d5-abd4-06789730391d','2022-06-24 00:00:00','2022-06-24 08:00','2022-08-26 00:00:00','2022-08-26 18:00','CIP','CIPPWR','',now(),'CDM-41820',now(),'CDM-41820',1,5058504,1573714);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), 'a7f7dde3-1fa1-407d-b201-b5f7bf8c0273','2023-03-17 00:00:00','2023-03-17 16:30','2023-05-10 00:00:00','2023-05-10 20:00','CIP','CIPPNC','',now(),'CDM-41820',now(),'CDM-41820',1,6001542,1634973);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), 'adc942bd-bd84-4373-aaef-36b0f8388633','2022-01-13 00:00:00','2022-01-13 12:00','2022-01-19 00:00:00','2022-01-19 16:06','CIP','CIPMFSTP','',now(),'CDM-41820',now(),'CDM-41820',1,6004244,1569267);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), 'c700f984-0161-40fa-a434-1d0e7c41656d','2023-08-15 00:00:00','2023-08-15 08:00','2023-09-08 00:00:00','2023-09-08 17:50','CIPS',NULL,'',now(),'CDM-41820',now(),'CDM-41820',1,5071080,1722094);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), 'c44e2434-7141-459a-87a2-64077c3810fb','2022-08-29 00:00:00','2022-08-29 10:00','2022-11-01 00:00:00','2022-11-01 08:00','CIPS',NULL,'',now(),'CDM-41820',now(),'CDM-41820',1,6005285,1574540);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), 'b13342e0-fa3e-40b5-9bbd-6dc53d873df6','2023-12-22 00:00:00','2023-12-22 08:00','2023-01-25 00:00:00','2023-01-25 17:30','CIPS',NULL,'',now(),'CDM-41820',now(),'CDM-41820',1,5059325,1801292);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), 'bf04f017-017d-437f-a860-5177ca3096c6','2023-01-31 00:00:00','2023-01-31 11:00','2023-03-15 00:00:00','2023-03-15 16:13','CIPS',NULL,'',now(),'CDM-41820',now(),'CDM-41820',1,5030164,1612333);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), 'bc9c39e1-6332-4f78-9b74-decaaaea25b3','2020-04-20 00:00:00','2020-04-20 05:00','2024-01-24 00:00:00','2024-01-24 14:00','CIPS',NULL,'',now(),'CDM-41820',now(),'CDM-41820',1,5035704,1821550);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), 'ee678beb-6357-4e5e-bcc0-82ee9265cb1d','2023-08-24 00:00:00','2023-08-24 21:00','2023-08-25 00:00:00','2023-08-25 21:00','CIP','CIPPWR','',now(),'CDM-41820',now(),'CDM-41820',1,6047122,1727163);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), 'b8c3562b-ebf4-4841-b100-59fa45aa4f9d','2024-03-09 00:00:00','2024-03-09 08:00','2024-03-13 00:00:00','2024-03-13 12:30','PLCC','REUNIF','',now(),'CDM-41820',now(),'CDM-41820',1,5077326,1842346);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), 'dc188dd1-48cb-4cba-bf02-e5bbfadb236e','2020-07-06 00:00:00','2020-07-06 23:35','2020-08-07 00:00:00','2020-08-07 08:45','CIP','CIPPRCRS','',now(),'CDM-41820',now(),'CDM-41820',1,5091759,1533823);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '9fa949c0-0d10-4247-9b94-e9666d0bcd83','2022-08-29 00:00:00','2022-08-29 10:00','2022-11-01 00:00:00','2022-11-01 08:00','CIPS',NULL,'',now(),'CDM-41820',now(),'CDM-41820',1,6005285,1574541);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '37790e10-5ced-4ffa-bb0a-c43e7fe63ffc','2020-10-19 00:00:00','2020-10-19 08:00','2021-05-19 00:00:00','2021-05-19 13:00','CIPS',NULL,'',now(),'CDM-41820',now(),'CDM-41820',1,5095972,1559127);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '3811f6ee-9e28-412b-bf8b-b86b5ce9659e','2022-06-24 00:00:00','2022-06-24 08:00','2022-08-26 00:00:00','2022-08-26 18:00','CIP','CIPPWR','',now(),'CDM-41820',now(),'CDM-41820',1,5058504,1573713);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '4f0d086a-1c21-407f-b631-f713be32c896','2022-08-30 00:00:00','2022-08-30 21:17','2022-09-07 00:00:00','2022-09-07 11:24','CIPS',NULL,'',now(),'CDM-41820',now(),'CDM-41820',1,6005310,1574603);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), 'da566fdc-3f7c-49f7-a58d-b9684e47d0a8','2023-09-07 00:00:00','2023-09-07 09:30','2023-09-09 00:00:00','2023-09-09 07:45','CIPS',NULL,'',now(),'CDM-41820',now(),'CDM-41820',1,6002330,1791200);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), 'f3849618-f0e9-4222-bc5d-29625d5a25c5','2022-01-27 00:00:00','2022-01-27 17:00','2022-03-03 00:00:00','2022-03-03 16:00','CIPS',NULL,'',now(),'CDM-41820',now(),'CDM-41820',1,5096606,1569986);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), 'e692aaed-c55e-4ed7-9b59-9bbc1a2b51cf','2024-03-09 00:00:00','2024-03-09 08:00','2024-03-13 00:00:00','2024-03-13 12:30','PLCC','REUNIF','',now(),'CDM-41820',now(),'CDM-41820',1,5077326,1842348);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '8336ac4a-8986-40b1-ab8e-a08c6ec9e1b3','2018-06-30 00:00:00','2018-06-30 10:00:00','2019-12-06 00:00:00','2019-12-06 11:00:00','CIPS','','',now(),'CDM-41820',now(),'CDM-41820',1,5022482,328177);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '33097a19-bf56-40e9-8bac-2db8c1aa4465','2020-07-31 00:00:00','2020-07-31 08:00','2020-08-03 00:00:00','2020-08-03 09:00','CIPS',NULL,'',now(),'CDM-41820',now(),'CDM-41820',1,5044791,1557696);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '9d1dc963-ab0a-4de4-a3e6-838e19183eb6','2023-12-13 00:00:00','2023-12-13 16:00','2024-01-05 00:00:00','2024-01-05 16:30','CIP','CIPNHC','',now(),'CDM-41820',now(),'CDM-41820',1,5024802,1795400);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), 'ab2a3087-ac86-4ca9-91f2-a1bf1934126d','2024-03-09 00:00:00','2024-03-09 08:00','2024-03-13 00:00:00','2024-03-13 12:30','PLCC','REUNIF','',now(),'CDM-41820',now(),'CDM-41820',1,5077326,1842345);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '19959d7b-8c89-4a8b-b1fe-fef460495654','2022-01-27 00:00:00','2022-01-27 08:00','2022-03-02 00:00:00','2022-03-02 11:00','CIPS',NULL,'',now(),'CDM-41820',now(),'CDM-41820',1,5096615,1569973);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '88f241b2-d8a6-495b-b343-9388851e6b9d','2024-03-09 00:00:00','2024-03-09 08:00','2024-03-13 00:00:00','2024-03-13 12:30','PLCC','REUNIF','',now(),'CDM-41820',now(),'CDM-41820',1,5077326,1842344);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '6a4af4b3-ae88-4650-9bd3-31b06901aeb6','2020-08-31 00:00:00','2020-08-31 08:00','2020-12-31 00:00:00','2020-12-31 16:00','CIP','CIPB','',now(),'CDM-41820',now(),'CDM-41820',1,5096578,1557718);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), 'e66fce16-25d2-4397-a262-3c9b98115177','2023-12-22 00:00:00','2023-12-22 08:00','2024-01-25 00:00:00','2024-01-25 17:30','CIPS',NULL,'',now(),'CDM-41820',now(),'CDM-41820',1,5059325,1801291);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '4c31bc21-fc19-4bf8-85bc-4ff7c8b77f63','2024-03-09 00:00:00','2024-03-09 08:00','2024-03-13 00:00:00','2024-03-13 12:30','PLCC','REUNIF','',now(),'CDM-41820',now(),'CDM-41820',1,5077326,1842347);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), 'cb9dd3af-2db8-49ff-bb50-f274119aea00','2024-01-08 00:00:00','2024-01-08 20:41','2024-03-01 00:00:00','2024-03-01 13:00','CIPS',NULL,'',now(),'CDM-41820',now(),'CDM-41820',1,5030150,1813006);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '15e63424-7c9e-4d2c-ad23-ad4b5fc6cfe4','2012-10-22 00:00:00','2012-10-22 12:00:00','2013-01-02 00:00:00','2013-01-02 00:00:00','CIPS','','',now(),'CDM-41820',now(),'CDM-41820',1,5061489,278742);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), 'fdc1035a-6eeb-4306-9e6a-570af221c71d','2022-07-27 00:00:00','2022-07-27 16:30','2022-08-04 00:00:00','2022-08-04 08:00','CIPS',NULL,'',now(),'CDM-41820',now(),'CDM-41820',1,6005580,1573715);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '397295d4-f768-4d9a-a03a-a38473217b52','2022-05-03 00:00:00','2022-05-03 08:00','2022-05-04 00:00:00','2022-05-04 20:09','CIP','CIPB','',now(),'CDM-41820',now(),'CDM-41820',1,6004629,1572684);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '6435d21e-c4e5-44cd-ba74-8a5a24f24b73','2021-04-06 00:00:00','2021-04-06 08:00','2021-05-21 00:00:00','2021-05-21 08:47',NULL,NULL,'',now(),'CDM-41820',now(),'CDM-41820',1,5069831,1563788);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '8f89916f-7d2f-4d99-82a2-63f167b671ff','2021-12-09 00:00:00','2021-12-09 00:00','2021-12-24 00:00:00','2021-12-24 19:00','CIP','CIPB','',now(),'CDM-41820',now(),'CDM-41820',1,5024341,1568598);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), 'fa5a0146-e6f5-4c96-a32a-93c281bdad99','2022-03-14 00:00:00','2022-03-14 22:00','2022-03-15 00:00:00','2022-03-15 18:15','CIP','CIPB','',now(),'CDM-41820',now(),'CDM-41820',1,6005459,1570591);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), 'ce1b4c04-10ca-4e23-a562-d7ce458ff317','2024-01-03 00:00:00','2024-01-03 20:00','2024-01-07 00:00:00','2024-01-07 19:00','CIPS',NULL,'',now(),'CDM-41820',now(),'CDM-41820',1,6094486,1810229);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), 'e18f7b38-723b-4f26-909b-b6f608bc2903','2024-01-17 00:00:00','2024-01-17 08:00','2024-01-31 00:00:00','2024-01-31 10:00','CIPS',NULL,'',now(),'CDM-41820',now(),'CDM-41820',1,6094486,1823650);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), 'b532d0b6-1ded-476b-968f-a1b98ac22a9e','2021-07-29 00:00:00','2021-07-29 08:00','2021-08-20 00:00:00','2021-08-20 20:00','CIP','CIPB','',now(),'CDM-41820',now(),'CDM-41820',1,5069770,1565327);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '8805a443-dfde-4fd9-9d35-c614be58d42c','2023-07-28 00:00:00','2023-07-28 14:00','2023-08-14 00:00:00','2023-08-14 14:00','CIP','CIPB','',now(),'CDM-41820',now(),'CDM-41820',1,6001952,1724346);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '6013bd74-c570-465d-8056-69f6590f2465','2020-08-31 00:00:00','2020-08-31 12:00','2021-01-06 00:00:00','2021-01-06 15:00','CIP','CIPB','',now(),'CDM-41820',now(),'CDM-41820',1,5096578,1557698);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '44304e89-8ac2-487d-889e-1b072dff227e','2018-01-25 00:00:00','2018-01-25 10:00:00','2018-07-11 00:00:00','2018-07-11 10:00:00','CIPS','','',now(),'CDM-41820',now(),'CDM-41820',1,5073247,332177);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), 'd2623f3d-9062-4334-aa0b-615d4e511d06','2018-12-26 00:00:00','2018-12-26 10:00:00','2019-01-25 00:00:00','2019-01-25 09:00:00','CIP','CIPDA','',now(),'CDM-41820',now(),'CDM-41820',1,5058504,332189);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '031c22e5-8dd4-44dd-95b0-e14faca26516','2024-03-01 00:00:00','2024-03-01 18:00','2024-03-06 00:00:00','2024-03-06 22:00','CIPS',NULL,'',now(),'CDM-41820',now(),'CDM-41820',1,6001221,1842141);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '481aa24d-73c0-40ea-bf44-8bb7a84e260d','2023-11-07 00:00:00','2023-11-07 20:00','2024-01-15 00:00:00','2024-01-15 10:00','CIP','CIPO','',now(),'CDM-41820',now(),'CDM-41820',1,6028804,1774609);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '81c75cc1-7620-437e-9d37-7e99c640b7e8','2023-07-10 00:00:00','2023-07-10 19:00','2023-07-23 00:00:00','2023-07-23 06:45','CIP','CIPRA','',now(),'CDM-41820',now(),'CDM-41820',1,5084688,1701609);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '194cc0d6-bcdd-4c45-805a-5478aee5bbca','2021-02-08 00:00:00','2021-02-08 08:00','2021-03-01 00:00:00','2021-03-01 11:00','CIPS',NULL,'',now(),'CDM-41820',now(),'CDM-41820',1,5086642,1562536);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), 'f35bd1ab-de29-461b-91c3-654c8dba6656','2023-05-15 00:00:00','2023-05-15 18:58','2023-05-16 00:00:00','2023-05-16 20:00','CIPS',NULL,'',now(),'CDM-41820',now(),'CDM-41820',1,5084926,1671973);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '65a985df-f37d-4386-848b-d1d1741b44f5','2022-05-06 00:00:00','2022-05-06 17:50','2022-05-15 00:00:00','2022-05-15 15:00','CIP','CIPOR','',now(),'CDM-41820',now(),'CDM-41820',1,6005940,1571856);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), 'db52d71c-ac5b-4e52-a054-bd2e6a614c63','2024-02-23 00:00:00','2024-02-23 17:00','2024-05-14 00:00:00','2024-05-14 14:00','CIP','CIPPWR','',now(),'CDM-41820',now(),'CDM-41820',1,5039481,1833481);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '623dba5c-65f7-4df5-baac-e896db272460','2018-07-10 00:00:00','2018-07-10 10:00:00','2018-07-12 00:00:00','2018-07-12 09:00:00','CIP','CIPDA','',now(),'CDM-41820',now(),'CDM-41820',1,5063241,328426);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '0373ea8e-d990-400e-a5ab-a93706f1efdb','2017-11-02 00:00:00','2017-11-02 18:00:00','2017-11-13 00:00:00','2017-11-13 14:30:00','CIP','CIR','',now(),'CDM-41820',now(),'CDM-41820',1,5030166,322525);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), 'c50ec6f5-9ff4-4ecf-8443-6b18567c9327','2020-10-26 00:00:00','2020-10-26 08:00','2021-01-08 00:00:00','2021-01-08 09:00','CIP','CIPB','',now(),'CDM-41820',now(),'CDM-41820',1,5090576,1561243);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '33caf8b8-be07-4db8-9bc3-10985e7e8b80','2021-12-04 00:00:00','2021-12-04 21:00','2021-12-06 00:00:00','2021-12-06 09:30','CIPS',NULL,'',now(),'CDM-41820',now(),'CDM-41820',1,5045013,1570002);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '2b714e8f-c5fe-4c0b-a7f7-efc67f6adcae','2020-08-04 00:00:00','2020-08-04 14:00','2020-08-11 00:00:00','2020-08-11 17:00','CIPS',NULL,'',now(),'CDM-41820',now(),'CDM-41820',1,6000162,1556898);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '32489b6e-b3f1-4203-bd08-c8e206fad4ba','2023-12-30 00:00:00','2023-12-30 09:00','2024-02-02 00:00:00','2024-02-02 16:00','CIP','CIPIS','',now(),'CDM-41820',now(),'CDM-41820',1,6098285,1814867);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), 'dca5d5e2-da28-4b4f-92d0-218211d2dfe7','2024-01-31 00:00:00','2024-01-31 12:47','2024-02-08 00:00:00','2024-02-08 15:00','CIP','CIPRA','',now(),'CDM-41820',now(),'CDM-41820',1,5045827,1821418);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '8147d4b6-6400-4376-a5ab-d129d6921af9','2022-12-01 00:00:00','2022-12-01 17:00','2023-01-05 00:00:00','2023-01-05 14:59','CIPS',NULL,'',now(),'CDM-41820',now(),'CDM-41820',1,5074514,1593545);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), 'f44eeec4-014c-4c79-a35e-f2b1541e2eae','2024-02-06 00:00:00','2024-02-06 17:30','2024-05-07 00:00:00','2024-05-07 20:00','CIP','CIPO','',now(),'CDM-41820',now(),'CDM-41820',1,5069770,1825260);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), 'ae7de9be-c40c-4c02-b772-66ea7cd275e7','2023-10-20 00:00:00','2023-10-20 08:00','2023-11-09 00:00:00','2023-11-09 16:00','CIPS',NULL,'',now(),'CDM-41820',now(),'CDM-41820',1,6082318,1765334);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), 'ddf93e6d-ec51-4fa2-95ce-c7b5ce3dc106','2011-07-27 00:00:00','2011-07-27 09:00:00','2012-10-19 00:00:00','2012-10-19 18:00:00','CIPS','','',now(),'CDM-41820',now(),'CDM-41820',1,5041119,260406);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '0b174d53-dd14-46ae-be66-0673039a12de','2020-03-23 00:00:00','2020-03-23 14:00:00','2020-04-01 00:00:00','2020-04-01 20:53:00','CIPS','','',now(),'CDM-41820',now(),'CDM-41820',1,5096578,340007);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), 'b891e57c-bd91-41da-8d64-4a4ae9d69c77','2011-12-08 00:00:00','2011-12-08 09:00:00','2012-06-25 00:00:00','2012-06-25 17:00:00','CIPS','','',now(),'CDM-41820',now(),'CDM-41820',1,5057677,268558);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '1967bba8-34f9-4b88-9bfc-807c73f6fcfc','2020-04-21 00:00:00','2020-04-21 10:00:00','2020-08-25 00:00:00','2020-08-25 15:00',NULL,NULL,'',now(),'CDM-41820',now(),'CDM-41820',1,5096235,340455);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), 'c8f14f66-a583-443c-aab2-c86b229052c0','2024-03-08 00:00:00','2024-03-08 18:05','2024-03-15 00:00:00','2024-03-15 08:00','CIP','CIPRA','',now(),'CDM-41820',now(),'CDM-41820',1,5074514,1844005);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '6910d4da-8a69-462c-a0f5-34c8a2d2360a','2017-10-13 00:00:00','2017-10-13 18:00:00','2017-10-20 00:00:00','2017-10-20 15:00:00','CIP','CISR','',now(),'CDM-41820',now(),'CDM-41820',1,5087834,322293);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), 'c24cbbe7-85d7-4665-b851-8e238ca9408d','2023-10-26 00:00:00','2023-10-26 16:00','2024-01-08 00:00:00','2024-01-08 12:00','CIP','CIPPRCRS','',now(),'CDM-41820',now(),'CDM-41820',1,5023972,1801787);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), 'cbb7f4c4-381a-4848-a739-32aea5192d09','2018-09-13 00:00:00','2018-09-13 12:00:00','2018-09-24 00:00:00','2018-09-24 12:00:00','CIPS','','',now(),'CDM-41820',now(),'CDM-41820',1,5058507,330131);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), 'f40dccc7-ac4e-4484-bda1-8b091e41ed0a','2018-11-02 00:00:00','2018-11-02 22:00:00','2018-11-15 00:00:00','2018-11-15 17:00:00','CIP','CIPDA','',now(),'CDM-41820',now(),'CDM-41820',1,5045013,331121);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '5e3a78d8-d623-4161-b1b1-16da9fa0e4cf','2017-05-23 00:00:00','2017-05-23 14:00:00','2017-07-25 00:00:00','2017-07-25 17:59:00','CIP','CIPDA','',now(),'CDM-41820',now(),'CDM-41820',1,5022561,319164);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '331a9d1a-69e3-4416-8af0-9e4454fb5fab','2023-11-21 00:00:00','2023-11-21 14:00','2023-12-01 00:00:00','2023-12-01 13:30','CIP','CIPO','',now(),'CDM-41820',now(),'CDM-41820',1,5027293,1783131);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '8541c0b0-0334-43ea-a4f5-d9c5eaeb95ef','2023-12-01 00:00:00','2023-12-01 14:00','2024-05-16 00:00:00','2024-05-16 17:00','CIP','CIPB','',now(),'CDM-41820',now(),'CDM-41820',1,5069770,1790969);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '3df8cad4-495b-4592-b7df-ac743ac245b9','2018-02-23 00:00:00','2018-02-23 18:00:00','2018-03-02 00:00:00','2018-03-02 14:00:00','CIP','PIRC','',now(),'CDM-41820',now(),'CDM-41820',1,5084688,324914);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), 'c83caba7-94d5-4da0-9943-0bdcb4560de3','2018-05-18 00:00:00','2018-05-18 10:00:00','2018-05-24 00:00:00','2018-05-24 16:30:00','CIPS','','',now(),'CDM-41820',now(),'CDM-41820',1,5035918,327195);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), 'a22da91b-8df0-457d-8f87-fb8f233623be','2024-02-26 00:00:00','2024-02-26 17:03','2024-04-01 00:00:00','2024-04-01 16:00','CIP','CIPRA','',now(),'CDM-41820',now(),'CDM-41820',1,6108403,1846347);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '0ef1f20c-d36a-4e69-a60f-1dbc222be571','2020-05-11 00:00:00','2020-05-11 17:30:00','2020-11-13 00:00:00','2020-11-13 19:00','CIPS',NULL,'',now(),'CDM-41820',now(),'CDM-41820',1,5096615,340640);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '60897e3f-fc77-42e4-9b7a-e015fa5d3222','2021-05-26 00:00:00','2021-05-26 16:30','2021-08-05 00:00:00','2021-08-05 00:00',NULL,NULL,'',now(),'CDM-41820',now(),'CDM-41820',1,5091450,1563589);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '1b4229cf-fc96-4b1e-b555-0c6fd224f3d3','2023-06-20 00:00:00','2023-06-20 14:00','2023-09-08 00:00:00','2023-09-08 20:00','CIP','CIPDWP','',now(),'CDM-41820',now(),'CDM-41820',1,5095059,1685771);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '565e5986-b2c6-404f-89ba-0c4af955eead','2020-11-25 00:00:00','2020-11-25 08:00','2021-03-09 00:00:00','2021-03-09 08:00','CIP','CIPRA','',now(),'CDM-41820',now(),'CDM-41820',1,5043824,1561216);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '28da12cf-a99a-487e-9fb9-4b258393ec7b','2023-08-14 00:00:00','2023-08-14 08:00','2023-10-24 00:00:00','2023-10-24 12:00','CIPS',NULL,'',now(),'CDM-41820',now(),'CDM-41820',1,5022586,1755831);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '7ff9b756-4374-45fc-8f16-8b4b25ae9d7d','2019-01-28 00:00:00','2019-01-28 19:30:00','2019-02-15 00:00:00','2019-02-15 01:30:00','CIP','PII','',now(),'CDM-41820',now(),'CDM-41820',1,5044837,332759);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '3745c5c8-3697-45c3-85b6-159c9c92effc','2022-08-26 00:00:00','2022-08-26 00:00','2022-08-30 00:00:00','2022-08-30 10:00','CIPS',NULL,'',now(),'CDM-41820',now(),'CDM-41820',1,5074322,1574596);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '4385c111-a8fe-42e4-b022-d4aa56fb4d5f','2020-09-26 00:00:00','2020-09-26 20:00','2020-10-12 00:00:00','2020-10-12 08:00','CIP','CIPPL','',now(),'CDM-41820',now(),'CDM-41820',1,5058507,1558680);
	
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), 'ae918e0d-ac5b-486f-948b-7e5e55356e54','2008-09-19 00:00:00','2008-09-19 10:00:00','2010-12-18 00:00:00','2010-12-18 09:00:00','CIPS','','',now(),'CDM-41820',now(),'CDM-41820',1,5022365,220422);
	
	
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '86c5e9c4-f426-4ed9-8077-bca14d8c5672','2023-06-15 00:00:00','2023-06-15 15:30','2024-01-25 00:00:00','2024-01-25 12:30','CIP','CIPNHC','',now(),'CDM-41820',now(),'CDM-41820',1,5085935,1752916);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '97447a3b-4984-4f42-b2d6-e22407f46119','2016-02-05 00:00:00','2016-02-05 18:00:00','2016-05-27 00:00:00','2016-05-27 10:00:00','CIP','CISR','',now(),'CDM-41820',now(),'CDM-41820',1,5079996,309160);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '187e1f1d-ca03-4fda-a179-73604d08ca1b','2018-06-30 00:00:00','2018-06-30 10:00:00','2019-08-02 00:00:00','2019-08-02 17:00:00','CIPS','','',now(),'CDM-41820',now(),'CDM-41820',1,5084230,328117);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), 'c9f07990-92c1-4691-918a-9e62c68bc9e7','2023-08-28 00:00:00','2023-08-28 17:00','2023-09-21 00:00:00','2023-09-21 17:00','CIP','CIPSSA','',now(),'CDM-41820',now(),'CDM-41820',1,5063007,1734815);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), 'b42e3b36-2200-441e-9a26-32c76fd817d1','2023-07-05 00:00:00','2023-07-05 10:30','2023-08-15 00:00:00','2023-08-15 16:12','CIP','CIPR','',now(),'CDM-41820',now(),'CDM-41820',1,5095050,1699222);
	
/*
-- This fix will be part of CDM-41338	
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), 'bc9cbfd0-e9cb-42a7-b266-76eebcdb2645','2023-12-30 00:00:00','2023-12-30 09:00','2024-02-02 00:00:00','2024-02-02 16:59','CIPS',NULL,'',now(),'CDM-41820',now(),'CDM-41820',1,6098285,1806165);
*/	
	
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), 'b73849ce-4a16-47f5-9805-817cf4522458','2019-12-04 00:00:00','2019-12-04 17:00:00','2019-12-15 00:00:00','2019-12-15 20:00:00','CIPS','','',now(),'CDM-41820',now(),'CDM-41820',1,5094823,338644);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), 'c9a39d5c-d9e5-4b68-8913-fff5190c8472','2018-01-03 00:00:00','2018-01-03 17:30:00','2018-06-30 00:00:00','2018-06-30 10:00:00','CIPS','','',now(),'CDM-41820',now(),'CDM-41820',1,5059495,323993);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), 'd890ad96-c619-401d-bc65-2943793e276b','2016-10-26 00:00:00','2016-10-26 18:30:00','2016-11-22 00:00:00','2016-11-22 14:00:00','CIP','PIRC','',now(),'CDM-41820',now(),'CDM-41820',1,5082186,315159);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), 'a842879b-30d0-44ff-a26f-cf92661ef81a','2017-05-30 00:00:00','2017-05-30 18:00:00','2017-06-21 00:00:00','2017-06-21 09:00:00','CIP','CIPDA','',now(),'CDM-41820',now(),'CDM-41820',1,5064762,319245);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), 'b5bb584c-322c-4810-9e9a-50e4ed46e6c0','2017-07-27 00:00:00','2017-07-27 17:00:00','2017-08-16 00:00:00','2017-08-16 10:00:00','CIP','PIRC','',now(),'CDM-41820',now(),'CDM-41820',1,5023204,320410);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '5ef5ff20-2589-4dd7-9799-92cb65271816','2017-05-05 00:00:00','2017-05-05 18:00:00','2017-05-16 00:00:00','2017-05-16 16:00:00','CIPS','','',now(),'CDM-41820',now(),'CDM-41820',1,5079996,318940);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '18cafc10-3fc6-40e2-8c4f-33750974e9ff','2022-01-28 00:00:00','2022-01-28 20:00','2022-02-02 00:00:00','2022-02-02 16:18','CIPS',NULL,'',now(),'CDM-41820',now(),'CDM-41820',1,6004183,1569735);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '7e3251d1-7334-470b-90ca-8298179efce4','2022-06-28 00:00:00','2022-06-28 16:21','2022-09-19 00:00:00','2022-09-19 11:00','CIPS',NULL,'',now(),'CDM-41820',now(),'CDM-41820',1,5063007,1573092);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '064df0a4-4cc1-4f65-9d75-bff916d951c4','2020-06-19 00:00:00','2020-06-19 11:00','2022-01-28 00:00:00','2022-01-28 19:00','CIPS',NULL,'',now(),'CDM-41820',now(),'CDM-41820',1,5086584,1533658);


-- Prince Georges
-- Case 	Client	Entry 		exit	   Placement 	
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), 'f3c38356-b548-411f-a40f-fbe20266fd1b','2023-09-27 00:00:00','2023-09-27 5:30 PM','2023-09-29 00:00:00','2023-09-29 12:00 PM','CIP','CIPO','',now(),'CDM-41820',now(),'CDM-41820',1,5069061,1751224);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), 'ba85dee6-ac13-46d5-be99-6bf8bba4a814','2022-05-20 00:00:00','2022-05-20 8:00 AM','2022-07-28 00:00:00','2022-07-28 2:00 PM','CIP','CIPPWR','',now(),'CDM-41820',now(),'CDM-41820',1,6005719,1573292);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '099a2cf0-457b-4554-ae53-73ee90688fbe','2022-05-20 00:00:00','2022-05-20 8:00 AM','2022-07-28 00:00:00','2022-07-28 2:00 PM','CIP','CIPPWR','',now(),'CDM-41820',now(),'CDM-41820',1,6005719,1573293);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), 'd9ef2a6d-d15f-4327-a1b1-37e60841715f','2023-05-30 00:00:00','2023-05-30 8:00 AM','2024-06-07 00:00:00','2024-06-07 12:00 PM','CIP','CIPTWV','',now(),'CDM-41820',now(),'CDM-41820',1,5074932,1680385);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '0a576d47-8539-4a1e-9853-e2e2555bca25','2022-07-26 00:00:00','2022-07-26 7:00 PM','2022-07-27 00:00:00','2022-07-27 2:00 PM','CIP','CIPCOPC','',now(),'CDM-41820',now(),'CDM-41820',1,5069061,1573638);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '6319e0b4-b7b7-4114-b0a7-a9da69f8b091','2023-09-27 00:00:00','2023-09-27 5:30 PM','2023-09-29 00:00:00','2023-09-29 12:00 PM','CIP','CIPO','',now(),'CDM-41820',now(),'CDM-41820',1,5069061,1751157);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '80b11564-9a41-4ed9-9a7f-e912427449dd','2023-05-30 00:00:00','2023-05-30 8:00 AM','2024-06-07 00:00:00','2024-06-07 12:00 PM','CIP','CIPTWV','',now(),'CDM-41820',now(),'CDM-41820',1,5074932,1680386);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), 'fe122b74-0eab-42db-9efe-61595f755132','2023-09-27 00:00:00','2023-09-27 5:30 PM','2023-09-29 00:00:00','2023-09-29 12:00 PM','CIP','CIPO','',now(),'CDM-41820',now(),'CDM-41820',1,5069061,1751191);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '49679033-f27e-4b4f-89e0-f46a0e882642','2024-01-26 00:00:00','2024-01-26 8:00 PM','2024-03-18 00:00:00','2024-03-18 1:00 PM','CIP','CIPB','',now(),'CDM-41820',now(),'CDM-41820',1,5054527,1820584);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '0b2a70cb-77af-4f8d-b4d9-54a114e70ff7','2021-06-05 00:00:00','2021-06-05 5:00','2021-06-21 00:00:00','2021-06-21 5:00','CIP','CIPO','',now(),'CDM-41820',now(),'CDM-41820',1,5069061,1563634);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), 'ae3c9148-e6ed-4a64-93ea-b6b4679c0873','2022-06-11 00:00:00','2022-06-11 8:00 PM','2023-04-26 00:00:00','2023-04-26 5:00 PM','CIP','CIPI','',now(),'CDM-41820',now(),'CDM-41820',1,5074932,1572711);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '88556806-2a08-4b45-9b70-b05fc4ed38c1','2022-07-26 00:00:00','2022-07-26 7:00 PM','2022-07-27 00:00:00','2022-07-27 2:00 PM','CIP','CIPCOPC','',now(),'CDM-41820',now(),'CDM-41820',1,5069061,1573639);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '13b61475-3e2e-4b4d-bd85-dc135a9afbab','2022-06-11 00:00:00','2022-06-11 8:00 PM','2023-04-26 00:00:00','2023-04-26 2:00 PM','CIP','CIPI','',now(),'CDM-41820',now(),'CDM-41820',1,5074932,1572714);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '8b1ec10d-1db4-4e5c-84c2-ac1b7e6befbe','2023-05-30 00:00:00','2023-05-30 8:00 AM','2023-10-04 00:00:00','2023-10-04 3:30 PM','CIP','CIPO','',now(),'CDM-41820',now(),'CDM-41820',1,5071750,1680383);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '83c29710-5933-4cf0-aea0-c769509bc44f','2023-10-06 00:00:00','2023-10-06 3:00 PM','2023-11-01 00:00:00','2023-11-01 10:00 AM','CIP','CIPNHC','',now(),'CDM-41820',now(),'CDM-41820',1,5096216,1756231);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), 'df8fedeb-1927-4ede-b6e9-6812f6f00604','2023-05-30 00:00:00','2023-05-30 8:00 AM','2023-10-04 00:00:00','2023-10-04 3:30 PM','CIP','CIPO','',now(),'CDM-41820',now(),'CDM-41820',1,5071750,1680384);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '61f03df4-b35f-4fe2-8003-b5adf6a4394d','2024-02-02 00:00:00','2024-02-02 6:30 PM','2024-04-23 00:00:00','2024-04-23 5:00 PM','CIP','CIPI','',now(),'CDM-41820',now(),'CDM-41820',1,5071750,1824720);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '5abd3db3-2188-4ef8-bb70-9b0754563b4e','2024-01-26 00:00:00','2024-01-26 9:31 PM','2024-01-28 00:00:00','2024-01-28 1:00 AM','CIP','CIPB','',now(),'CDM-41820',now(),'CDM-41820',1,6005110,1825859);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '16718b1f-57be-4ea2-a603-b6b46385a830','2020-05-11 00:00:00','2020-05-11 5:00 PM','2020-05-12 00:00:00','2020-05-12 5:00 PM','CIP','CIPO','',now(),'CDM-41820',now(),'CDM-41820',1,5069061,1447689);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '07e836de-7163-4a35-84b8-1b2596e4138c','2021-06-05 00:00:00','2021-06-05 5:00 PM','2021-06-21 00:00:00','2021-06-21 17:00','CIP','CIPO','',now(),'CDM-41820',now(),'CDM-41820',1,5074932,1563633);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), 'e51513f4-baee-42f8-80c1-4fb4b9dd8dd6','2022-06-11 00:00:00','2022-06-11 8:00 AM','2023-08-09 00:00:00','2023-08-09 11:00 AM','CIP','CIPDWP','',now(),'CDM-41820',now(),'CDM-41820',1,5074932,1572710);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '7d98c5b6-5fc6-4b87-be26-0f49bc3e1174','2023-05-30 00:00:00','2023-05-30 8:00 AM','2024-06-07 00:00:00','2024-06-07 12:00 PM','CIP','CIPTWV','',now(),'CDM-41820',now(),'CDM-41820',1,5074932,1680387);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '37738cbc-3099-4ca5-9909-0dfbb32afd81','2022-07-26 00:00:00','2022-07-26 7:00 PM','2022-07-27 00:00:00','2022-07-27 2:00 PM','CIP','CIPCOPC','',now(),'CDM-41820',now(),'CDM-41820',1,5069061,1573640);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '1317f45a-3b5b-4f96-a879-14ac4eb281ac','2023-04-25 00:00:00','2023-04-25 5:00 PM','2023-06-01 00:00:00','2023-06-01 7:00 AM','CIP','CIPB','',now(),'CDM-41820',now(),'CDM-41820',1,6030371,1656327);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '41a314d1-4d80-4546-9aa8-028e079a54ac','2024-02-02 00:00:00','2024-02-02 6:30 PM','2024-04-23 00:00:00','2024-04-23 5:00 PM','CIP','CIPI','',now(),'CDM-41820',now(),'CDM-41820',1,5071750,1824721);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), 'bfe94bf3-3f8a-4ca0-aaf8-d7b762689286','2020-05-11 00:00:00','2020-05-11 5:00 PM','2020-05-12 00:00:00','2020-05-12 5:00 PM','CIP','CIPO','',now(),'CDM-41820',now(),'CDM-41820',1,5069061,1447691);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), 'a0fc6046-141e-4cf0-89f6-2bed35c782fe','2023-06-26 00:00:00','2023-06-26 5:00 PM','2023-07-17 00:00:00','2023-07-17 7:00 AM','CIP','CIPB','',now(),'CDM-41820',now(),'CDM-41820',1,5094433,1688784);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '7e589d1c-105c-43da-98ac-a45e96df8649','2023-03-10 00:00:00','2023-03-10 5:30 PM','2023-03-21 00:00:00','2023-03-21 9:30 PM','CIP','CIPPRCRS','',now(),'CDM-41820',now(),'CDM-41820',1,6018905,1638041);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), 'a5bad913-9b03-48da-b2c4-f8f9a0479bb9','2022-06-03 00:00:00','2022-06-03 8:00 AM','2022-12-06 00:00:00','2022-12-06 2:00 PM','CIP','CIPB','',now(),'CDM-41820',now(),'CDM-41820',1,6005940,1572698);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), 'e19dc17e-9837-41ac-b2eb-d0124d8b301b','2023-05-03 00:00:00','2023-05-03 8:00 AM','2023-05-04 00:00:00','2023-05-04 1:00 PM','CIP','CIPMFSTP','',now(),'CDM-41820',now(),'CDM-41820',1,5074932,1682514);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), 'babedbfd-e0d2-481c-9703-8078f6c26695','2020-07-21 00:00:00','2020-07-21 5:00 PM','2020-09-02 00:00:00','2020-09-02 12:30 PM','CIPS',NULL,'',now(),'CDM-41820',now(),'CDM-41820',1,5047279,1556711);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), 'd0c6697c-7b7d-4d28-92d8-6e72007c91a9','2023-04-19 00:00:00','2023-04-19 5:00 PM','2024-04-29 00:00:00','2024-04-29 8:00 AM','CIPS',NULL,'',now(),'CDM-41820',now(),'CDM-41820',1,6001858,1656294);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '2f8779aa-1360-49c0-a7e1-9a76c04d4225','2022-01-05 00:00:00','2022-01-05 5:00 PM','2022-01-07 00:00:00','2022-01-07 10:00 AM','CIP','CIPMFSTP','',now(),'CDM-41820',now(),'CDM-41820',1,5093816,1569282);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), 'd17b2b93-9388-403f-abe0-fabd33ecc193','2024-03-28 00:00:00','2024-03-28 5:00 PM','2024-04-09 00:00:00','2024-04-09 5:00 PM','CIPS',NULL,'',now(),'CDM-41820',now(),'CDM-41820',1,6001221,1852210);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), 'e11294aa-bf76-4194-8927-6e4b2aeb5692','2023-10-10 00:00:00','2023-10-10 9:00 PM','2024-05-28 00:00:00','2024-05-28 8:00 PM','CIP','CIPR','',now(),'CDM-41820',now(),'CDM-41820',1,5093028,1757356);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '82e3dbf4-4d69-4ee5-91d0-ce5d7e672867','2022-04-04 00:00:00','2022-04-04 1:00 PM','2022-07-19 00:00:00','2022-07-19 6:00 PM','CIP','CIPNMS','',now(),'CDM-41820',now(),'CDM-41820',1,6005597,1572025);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '1f6608b9-63c7-4c0f-a970-423527bcf866','2022-03-02 00:00:00','2022-03-02 04:00 PM','2022-05-23 00:00:00','2022-05-23 05:00 PM','CIP','CIPPL','',now(),'CDM-41820',now(),'CDM-41820',1,6002341,1571225);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '33ca0126-e8eb-41d9-90ea-8f5efafbd1fb','2016-12-07 00:00:00','2016-12-07 10:00 AM','2017-10-10 00:00:00','2017-10-10 4:00 PM','CIP','CINC','',now(),'CDM-41820',now(),'CDM-41820',1,5023449,318704);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), 'a36148d5-5583-4e5d-b684-dd2df59fae80','2022-11-02 00:00:00','2022-11-02 2:25 PM','2023-04-20 00:00:00','2023-04-20 5:00 PM','CIP','CIPR','',now(),'CDM-41820',now(),'CDM-41820',1,5091149,1575909);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '6c554c87-7d4e-4c58-a915-dc8659413ed0','2021-07-15 00:00:00','2021-07-15 8:00 AM','2021-07-21 00:00:00','2021-07-21 11:00 AM',NULL,NULL,'',now(),'CDM-41820',now(),'CDM-41820',1,6002442,1568123);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '338f3fd7-8cc8-429b-b532-8d02547a08cd','2021-07-12 00:00:00','2021-07-12 8:00 AM','2021-07-23 00:00:00','2021-07-23 10:45 AM','CIP','CIPO','',now(),'CDM-41820',now(),'CDM-41820',1,5074932,1564719);
insert into cjams.placementcpahomes  
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid
		)
	values
	(	gen_random_uuid(), '29aafee3-47de-4420-8e2c-92380cbb7504','2021-07-23 00:00:00','2021-07-23 8:00 AM','2023-08-11 00:00:00','2023-08-11 9:30 AM','CIPS',NULL,'',now(),'CDM-41820',now(),'CDM-41820',1,5089469,1564994);
	
	
-- Make inactive all duplicate CPA Homes 
update placementcpahomes
set activeflag = 0,
	updatets = now(),
	updateuserid = 'CDM-41820'
where placementcpahomeid in (
		'3ffd9f50-5a9a-4a25-953a-65c272855817',
		'43d0345e-c69e-4dc7-b4f9-43937487251a',
		'b79b307a-b1d4-4531-9b77-6494394cb82d',
		'1f9a29be-9c12-4e07-895b-0087d3288519',
		'a0a4e338-2610-4be5-9249-6b66fd522c14',
		'efcb4f70-2f60-4575-b64e-abd3a8916485',
		'6d37d9fb-9051-4949-ae25-713c8b152cf9',
		'4e7ab1ed-ceee-4c0b-8d60-62a80060857c',
		'7770ebe7-97f3-4a97-8f1a-c8d669d9aa57',
		'1e7f3f6e-7899-44dd-acdc-a65323013807'
		) 
	and activeflag = 1 ;	
