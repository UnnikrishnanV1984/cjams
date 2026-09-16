-- CDM-22430 - CPA home end date change
/*
-- Issue Description: 
   User request to change the exit date of the CPA Home Placement
   
-- Case ID: 3192213
-- Client ID: 1707071 (EN'YAE ROSE PENDER) - ae590c93-1893-4e00-b7e1-99d82993f85f
-- Placement ID: 316576 - 2017-01-13 To 2021-09-30 - 8085d849-ffb3-4ad5-b2c8-2e51829107dc
-- Private Organization: 5000668 (The Children's Choice Of Maryland, Inc.)
-- CPA Office: 5000674 (Children's Choice Baltimore)

-- CPA Home: 5095060 (Marcia Jeffers)
-- Current 12/27/2019 to 07/17/2020
-- Update as 12/27/2019 to 07/25/2020	
   
-- Category/ Module: Placement (Case Management) 
-- Root cause: User error and this is a Closed Case 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select entrydt, entrytm, exitdt, exittm, exittypecd, exitreasoncd, updatets, updateuserid 
	from placementcpahomes 
where placementcpahomeid = '0ec2a624-90e5-498d-8933-644ea8759cc7'
	and activeflag = 1 ;

update placementcpahomes
set exitdt = '2020-07-25 09:00:00', -- 2020-07-17 09:00:00
	exittm = '2020-07-25 09:00:00', -- 2020-07-17 09:00:00
	-- exittypecd = 'CIP',
	-- exitreasoncd = 'CIPNHC',
	updatets = now(),
	updateuserid = 'CDM-22430'
where placementcpahomeid = '0ec2a624-90e5-498d-8933-644ea8759cc7'
	and activeflag = 1 ;

select provider_id, entry_dt, entry_tm, exit_dt, exit_tm, exit_type_cd, exit_reason_cd, update_ts, update_user_id  
   from tb_placement_cpa_homes  
where placement_cpa_home_id  = 43563
   and placement_id = 316576
   and delete_sw = 'N' ;

update tb_placement_cpa_homes
set exit_dt = '2020-07-25 09:00:00', -- NULL
	exit_tm = '2020-07-25 09:00:00', -- NULL
	exit_type_cd = 'CIP',
	exit_reason_cd = 'CIPNHC',
	update_ts = now(),
	update_user_id = 'CDM-22430'
where placement_cpa_home_id  = 43563
   and placement_id = 316576
   and delete_sw = 'N' ;
