-- CDM-11923- End CPA HOmes for Nikia Miller BCDSS
/*
-- Issue Description: 
   Error on Milestone Report due to closed Placement with Open CPA Homes
   Datafix to close the CPA Home Placement Information  
   
   Case ID: 3113281
   Client ID: 3562588 (NIKIA MILLER) - 6c2e3294-1b92-4105-aa6c-c06022830337
   Placement ID: 335807 - 07/15/2019 to 03/15/2021 - 5615c34e-f2ae-4069-b030-0b1de0713c76
   CPA Office Provider ID: 5069152	(CareRite T.F.C., Inc TFC - CPA Takoma Park)
   CPA Home Provider ID: 5090693 (Angela N Cowan)

   Client ID: 4221885 (SHADON SAVAGE) - 30f98ae7-ae97-4743-9e79-bf554dcb7ac0
   Placement ID: 327414 - 2018-05-14 to 2020-10-28  - 7b7de088-b2ee-4aac-b78d-ce2243018051
   CPA Office Provider ID: 5001646	(Progressive Steps CPA)
   CPA Home ID: 5081090	(Cynthia Mckinney)


-- Category/ Module: Placement (Case Management) 
-- Root cause: CJAMS is not having logic to end date CPA Homes with Placement Exit. placements after exit.
			   We will fix this with the Placement Modification User Story.
-- Pull request# TBD
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

-- Case ID: 3113281 
-- Client ID: 3562588 (NIKIA MILLER) - 6c2e3294-1b92-4105-aa6c-c06022830337
-- Placement ID: 335807 - 07/15/2019 to 03/15/2021 - 5615c34e-f2ae-4069-b030-0b1de0713c76
-- CPA Office Provider ID: 5069152	(CareRite T.F.C., Inc TFC - CPA Takoma Park)
-- CPA Home Provider ID: 5090693 (Angela N Cowan) - 29e1af41-52d9-4e25-a2f1-e0bccbae04f2

select entrydt, entrytm, exitdt, exittm, exittypecd, exitreasoncd, updatets, updateuserid 
	from placementcpahomes 
where placementcpahomeid = '29e1af41-52d9-4e25-a2f1-e0bccbae04f2'
	and activeflag = 1 ;

update placementcpahomes
set exitdt = '2021-03-15 00:00:00',
	exittm = '2021-03-15 09:16',
	exittypecd = 'PLCC',
	exitreasoncd = 'PLCCR',
	updatets = now(),
	updateuserid = 'CDM-11923'
where placementcpahomeid = '29e1af41-52d9-4e25-a2f1-e0bccbae04f2'
	and activeflag = 1 ;

select entry_dt, entry_tm, exit_dt, exit_tm, exit_type_cd, exit_reason_cd, update_ts, update_user_id  
   from tb_placement_cpa_homes  
where placement_id = 335807
   and delete_sw = 'N' ;
   
update tb_placement_cpa_homes
set exit_dt = '2021-03-15 00:00:00',
	exit_tm = '2021-03-15 09:16',
	exit_type_cd = 'PLCC',
	exit_reason_cd = 'PLCCR',
	update_ts = now(),
	update_user_id = 'CDM-11923'
where placement_id = 335807
   and delete_sw = 'N' ;

-- Client ID: 4221885 (SHADON SAVAGE) - 30f98ae7-ae97-4743-9e79-bf554dcb7ac0
-- Placement ID: 327414 - 2018-05-14 to 2020-10-28  - 7b7de088-b2ee-4aac-b78d-ce2243018051
-- CPA Office Provider ID: 5001646	(Progressive Steps CPA)
-- CPA Home ID: 5081090	(Cynthia Mckinney)

select entrydt, entrytm, exitdt, exittm, exittypecd, exitreasoncd, updatets, updateuserid 
	from placementcpahomes p 
where placementcpahomeid  = '5dbf88b2-019c-4f24-91b9-ffe88d9bb2ae'
	and activeflag = 1 ;

update placementcpahomes
set exitdt = '2020-10-28 00:00:00',
	exittm = '2020-10-28 18:30',
	exittypecd = 'CIP',
	exitreasoncd = 'CIPCOPC',
	updatets = now(),
	updateuserid = 'CDM-11923'
where placementcpahomeid = '5dbf88b2-019c-4f24-91b9-ffe88d9bb2ae'
	and activeflag = 1 ;
	
select entry_dt, entry_tm, exit_dt, exit_tm, exit_type_cd, exit_reason_cd, update_ts, update_user_id  
   from tb_placement_cpa_homes  
where placement_id = 327414
   and delete_sw = 'N' ;
   
update tb_placement_cpa_homes
set exit_dt = '2020-10-28 00:00:00',
	exit_tm = '2020-10-28 18:30',
	exit_type_cd = 'CIP',
	exit_reason_cd = 'CIPCOPC',
	update_ts = now(),
	update_user_id = 'CDM-11923'
where placement_id = 327414
   and delete_sw = 'N' ;
   