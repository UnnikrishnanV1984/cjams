-- CDM-11925 - CPA Homes- need to be end dated on Terrance Reaves
/*
-- Issue Description: 
   Error on Milestone Report due to Closed Placement with Open CPA Homes
   Datafix to close the CPA Home Placement Information  
   
   Case ID: 3275507
   Client ID: 3800975 (TERRANCE	REAVES) - 3e816b52-c728-4975-95cd-ad9421f72009
   1) Placement ID: 339196 - 2020-02-04 to 2020-06-22 - 87ed337d-7236-4d3b-b214-46fd9d87de76
	  CPA Office: 5001385 (WIN Family Services, Inc. CPA Baltimore)
	  CPA Home: 5069770 (Veronica Hughes)
	  
   2) Placement ID: 1559088 - 2020-10-07 to 2021-03-04 - a63744ed-b7ec-493a-9679-53e4bb7ff594
	  CPA Office: 5001420 (Baltimore Adolescent Treatment Guidance Organization CPA)	
      CPA Home : 5024802 (Darlene Ward)	

   Client ID: 3800976 (SIMYA FENNER) - fdffd340-4715-4d12-a7f0-18c13cbf54d4
   Placement ID: 339814 - 2018-06-04 to 2021-01-21 00:00:00 - 59c7aeb0-6502-449d-947d-0f465a91fc15
   CPA Office: 5000674 (Children's Choice Baltimore) 
   CPA Home: 5081404 (Karon Scotland)
   
-- Category/ Module: Placement (Case Management) 
-- Root cause: Code fix was promoted along with this datafix
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Client ID: 3800975 (TERRANCE	REAVES)
-- Placement ID: 339196 - 2020-02-04 to 2020-06-22 - 87ed337d-7236-4d3b-b214-46fd9d87de76
-- CPA Office: 5001385 (WIN Family Services, Inc. CPA Baltimore)
-- CPA Home: 5069770 (Veronica Hughes)

select placementcpahomeid, entrydt, entrytm, exitdt, exittm, exittypecd, exitreasoncd, updatets, updateuserid 
	from placementcpahomes 
where placementid  = '87ed337d-7236-4d3b-b214-46fd9d87de76'
    and placementcpahomeid = '9819fd56-cd2e-40c1-986f-1068b8e67370'
	and activeflag = 1 ;

update placementcpahomes
set exitdt = '2020-06-22 00:00:00',
	exittm = '2020-06-22 17:00',
	exittypecd = 'CIPS',
	exitreasoncd = '',
	updatets = now(),
	updateuserid = 'CDM-11925'
where placementid  = '87ed337d-7236-4d3b-b214-46fd9d87de76'
    and placementcpahomeid = '9819fd56-cd2e-40c1-986f-1068b8e67370'
	and activeflag = 1 ;

select placement_cpa_home_id, entry_dt, entry_tm, exit_dt, exit_tm, exit_type_cd, exit_reason_cd, update_ts, update_user_id  
   from tb_placement_cpa_homes  
where placement_id = 339196
	and placement_cpa_home_id  = 43321
	and delete_sw = 'N' ;
	
update tb_placement_cpa_homes
set exit_dt = '2020-06-22 00:00:00',
	exit_tm = '2020-06-22 17:00',
	exit_type_cd = 'CIPS',
	exit_reason_cd = '',
	update_ts = now(),
	update_user_id = 'CDM-11925'
where placement_id = 339196
	and placement_cpa_home_id  = 43321
	and delete_sw = 'N' ;
	
-- Placement ID: 1559088 - 2020-10-07 to 2021-03-04 - a63744ed-b7ec-493a-9679-53e4bb7ff594
-- CPA Office: 5001420 (Baltimore Adolescent Treatment Guidance Organization CPA)	
-- CPA Home : 5024802 (Darlene Ward)	
-- 2021-03-04 00:00:00 - 14:20	- reason PLCCR	 -type PLCC	

select placementcpahomeid, entrydt, entrytm, exitdt, exittm, exittypecd, exitreasoncd, updatets, updateuserid 
	from placementcpahomes 
where placementid  = 'a63744ed-b7ec-493a-9679-53e4bb7ff594'
    and placementcpahomeid = '8b6d9b06-ba12-47f9-ad3f-0ea9472c0d0c'
	and activeflag = 1 ;

update placementcpahomes
set exitdt = '2021-03-04 00:00:00',
	exittm = '2021-03-04 14:20',
	exittypecd = 'PLCC',
	exitreasoncd = 'PLCCR',
	updatets = now(),
	updateuserid = 'CDM-11925'
where placementid  = 'a63744ed-b7ec-493a-9679-53e4bb7ff594'
    and placementcpahomeid = '8b6d9b06-ba12-47f9-ad3f-0ea9472c0d0c'
	and activeflag = 1 ;

-- CJAMS placement, no data in tb_placement_cpa_homes

-- Client ID: 3800976 (SIMYA FENNER)
-- Placement ID: 339814 - 2018-06-04 to 2021-01-21 00:00:00 - 59c7aeb0-6502-449d-947d-0f465a91fc15
-- CPA Office: 5000674 (Children's Choice Baltimore) 
-- CPA Home: 5081404 (Karon Scotland)
select placementcpahomeid, entrydt, entrytm, exitdt, exittm, exittypecd, exitreasoncd, updatets, updateuserid 
	from placementcpahomes 
where placementid  = 'afe84d8f-2041-4493-8a11-8ab156e17f2b'
    and placementcpahomeid = 'be10ec85-9022-4e8e-8e34-61fed5bb7705'
	and activeflag = 1 ;


update placementcpahomes
set exitdt = '2021-01-21 00:00:00',
	exittm = '2021-01-21 12:26',
	exittypecd = 'PLCC',
	exitreasoncd = 'PLCCR',
	updatets = now(),
	updateuserid = 'CDM-11925'
where placementid  = 'afe84d8f-2041-4493-8a11-8ab156e17f2b'
    and placementcpahomeid = 'be10ec85-9022-4e8e-8e34-61fed5bb7705'
	and activeflag = 1 ;


select placement_cpa_home_id, entry_dt, entry_tm, exit_dt, exit_tm, exit_type_cd, exit_reason_cd, update_ts, update_user_id  
   from tb_placement_cpa_homes  
where placement_id = 339814
	and placement_cpa_home_id  = 43492
	and delete_sw = 'N' ;

   
update tb_placement_cpa_homes
set exit_dt = '2021-01-21 00:00:00',
	exit_tm = '2021-01-21 12:26',
	exit_type_cd = 'PLCC',
	exit_reason_cd = 'PLCCR',
	update_ts = now(),
	update_user_id = 'CDM-11925'
where placement_id = 339814
	and placement_cpa_home_id  = 43492
	and delete_sw = 'N' ;
	