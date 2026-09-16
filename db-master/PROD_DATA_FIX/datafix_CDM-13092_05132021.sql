-- CDM-13092 - CPA Home
/*
-- Issue Description: 
   User is unable to end date CPA Home on the Placement screen due to multiple open entries.
   Datafix to close the CPA Home Placement Information as of 3/1/19 at 1:00 p.m.  
   
-- Case ID: 3297443
-- Client ID: 1021408 (TEMPEST A AKINS)
-- Placement ID: 333306 - 2019-03-01 To Current - a5c3b851-330d-4312-ac7c-fa4118ec2853
-- Private Organization: 5000485 (Arrow Child & Family Ministries of Maryland, Inc.)
-- CPA Office: 5000487 (Arrow Child & Family - CPA TFC Baltimore)	
-- Program ID: 2768 (Arrow Treatment Foster Care Program)
   
-- Category/ Module: Placement (Case Management) 
-- Root cause: Data Issue (Code fix is already in place)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select entrydt, entrytm, exitdt, exittm, exittypecd, exitreasoncd, updatets, updateuserid 
	from placementcpahomes 
where placementcpahomeid = 'e84f494e-f4ed-4f51-8829-eb35cd4a6db5'
	and activeflag = 1 ;

update placementcpahomes
set exitdt = '2019-03-01 13:00:00',
	exittm = '2019-03-01 13:00',
	exittypecd = 'CIP',
	exitreasoncd = 'CIPNHC',
	updatets = now(),
	updateuserid = 'CDM-13092'
where placementcpahomeid = 'e84f494e-f4ed-4f51-8829-eb35cd4a6db5'
	and activeflag = 1 ;

select entry_dt, entry_tm, exit_dt, exit_tm, exit_type_cd, exit_reason_cd, update_ts, update_user_id  
   from tb_placement_cpa_homes  
where placement_cpa_home_id  = 41926
   and placement_id = 333306
   and delete_sw = 'N' ;
   
update tb_placement_cpa_homes
set exit_dt = '2019-03-01 13:00:00',
	exit_tm = '2019-03-01 13:00',
	exit_type_cd = 'CIP',
	exit_reason_cd = 'CIPNHC',
	update_ts = now(),
	update_user_id = 'CDM-13092'
where placement_cpa_home_id  = 41926
   and placement_id = 333306
   and delete_sw = 'N' ;
   