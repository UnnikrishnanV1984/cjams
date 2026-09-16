-- CDM-11926 - CPA Home was not end dated. BCDSS for Tori Carter
/*
-- Issue Description: 
   Error on Milestone Report due to closed Placement with Open CPA Homes
   Datafix to close the CPA Home Placement Information  
   
   Case ID: 3113281
   Client ID: 3562588 (NIKIA MILLER) - 6c2e3294-1b92-4105-aa6c-c06022830337
   Placement ID: 327502 - 2018-06-04 to 2020-12-18 00:00:00 - 59c7aeb0-6502-449d-947d-0f465a91fc15
   CPA Office: 5000674 (Children's Choice Baltimore) 
   CPA Home: 5093041 (Jacqueline Hamilton)

   
-- Category/ Module: Placement (Case Management) 
-- Root cause: Code fix was promoted along with this datafix
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select entrydt, entrytm, exitdt, exittm, exittypecd, exitreasoncd, updatets, updateuserid 
	from placementcpahomes 
where placementcpahomeid = '54c39df8-8cbe-4d3c-8ebf-924c8a612ebd'
	and activeflag = 1 ;

update placementcpahomes
set exitdt = '2020-12-18 00:00:00',
	exittm = '2020-12-18 19:30',
	exittypecd = 'CIP',
	exitreasoncd = 'CIPPWR',
	updatets = now(),
	updateuserid = 'CDM-1192'
where placementcpahomeid = '54c39df8-8cbe-4d3c-8ebf-924c8a612ebd'
	and activeflag = 1 ;

select entry_dt, entry_tm, exit_dt, exit_tm, exit_type_cd, exit_reason_cd, update_ts, update_user_id  
   from tb_placement_cpa_homes  
where placement_cpa_home_id  = 42362
   and placement_id = 327502
   and delete_sw = 'N' ;
   
update tb_placement_cpa_homes
set exit_dt = '2020-12-18 00:00:00',
	exit_tm = '2020-12-18 19:30',
	exit_type_cd = 'CIP',
	exit_reason_cd = 'CIPPWR',
	update_ts = now(),
	update_user_id = 'CDM-1192'
where placement_cpa_home_id  = 42362
   and placement_id = 327502
   and delete_sw = 'N' ;