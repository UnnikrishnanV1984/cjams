-- CDM-14208 - Placements need voided
/*
-- Issue Description: 
    User requested that following corrections need to be done in Placement 
	for Lanell Smith (CJAMS PID#3581727) in case#3276610.
	*Mentor Maryland-Baltimore CPA (3276610) needs placement dates from 3/18/2021 to 5/10/2021

	*Within Mentor Maryland, there needs to be 2 CPA Homes added (UNDER MENTOR MD)
	~Urcille Goddard 3/18/2021 to 4/16/2021
	~Jacqueline Holloman 4/16/2021 to 5/10/2021

	*Jacqueline Holloman that's currently in CJAMS independently 
	*as a DHS Home from 4/16/2021 to 5/6/2021 needs to be VOIDED or Taken out

-- Add CPA Homes
-- Placement ID: 1561628 - 2021-03-18 To 2021-05-10 - 5a53874c-03ed-45dc-b208-a8cd6f77cabb
-- Private Organization: 5001618 (MENTOR Maryland, Inc.)
-- CPA Office: 5001625 (MENTOR Maryland - Baltimore CPA)	
-- Program ID: 1545 (Medically Complex TFC- Mentor) - 2006-07-01 To 2022-06-30

-- CPA Home: 6001398 (Urcille  Goddard) - 3/18/2021 to 4/16/2021
-- CPA Home: 5065376 (Jacqueline Holloman) 	- 4/16/2021 to 5/10/2021

-- Void
-- Placement ID: 1562713 - 2021-04-16 To 2021-07-13 - d3e98451-1bd8-4872-8269-d80fbad8979c 
-- Local Department Home: 5013766 (Jacqueline Holloman)
-- Note: This Placenent is Voided in Prod on 07/13/2021
   
-- Category/ Module: Placement (Case Management) 
-- Root cause: Data Issue (Code fix is already in place)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Add CPA Homes
-- Placement ID: 1561628 - 2021-03-18 To 2021-05-10 - 5a53874c-03ed-45dc-b208-a8cd6f77cabb

select entrydt, entrytm, exitdt, exittm, exittypecd, exitreasoncd, updatets, updateuserid 
	from placementcpahomes 
where placementid = '5a53874c-03ed-45dc-b208-a8cd6f77cabb'
	and activeflag = 1 ;
	
-- CPA Home: 6001398 (Urcille  Goddard) - 3/18/2021 to 4/16/2021
insert into cjams.placementcpahomes
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), '5a53874c-03ed-45dc-b208-a8cd6f77cabb', '2021-03-18 00:00:00', '2021-03-18 19:45:00', 
		'2021-04-16 00:00:00', '2021-04-16 09:00:00', 'CIP', NULL,	'', 
		now(), 'CDM-14208', now(), 'CDM-14208', 1, 
		6001398, 1561628, NULL, NULL
	);


-- CPA Home: 5065376 (Jacqueline Holloman) 	- 4/16/2021 to 5/10/2021
insert into cjams.placementcpahomes
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), '5a53874c-03ed-45dc-b208-a8cd6f77cabb', '2021-04-16 00:00:00', '2021-04-16 09:00:00', 
		'2021-05-10 00:00:00', '2021-05-10 09:00:00', 'CIPS', NULL,	'', 
		now(), 'CDM-14208', now(), 'CDM-14208', 1, 
		5065376, 1561628, NULL, NULL
	);
