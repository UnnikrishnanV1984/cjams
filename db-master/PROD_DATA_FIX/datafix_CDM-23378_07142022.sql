-- CDM-23378 - Ancillary Child Account
/*
-- Issue Description: 
   Duplicate purchase authorizations blocking the Child Account Funds 
   
-- Case ID: 3208971
-- Client ID: 2376986 (MARY BARR) - 11724b62-1643-4ea6-839a-c4c8843e0704
-- Conserved Account ID: 14427 - $1985.40
-- 6004895	AmLink,LLC	1832871	Educational-High School (Paid) 	2022-05-16	2022-05-16	539.00	
-- 6004895	AmLink,LLC	1832872	Educational-High School (Paid) 	2022-05-16	2022-05-16	539.00

-- Category/ Module: Service Log/Purchase Authorization (Case Management) 
-- Root cause: User error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To Soft Delete the Duplucate Service Purchase Authorizations
select service_log_id, start_dt, end_dt, delete_sw, update_ts, update_user_id 
	from tb_service_purchase_authorization 
where authorization_id in ( 1832871, 1832872 )
	and delete_sw = 'N'
	and sprvsr_approval_status_cd is null
	and ads_approval_status_cd is null
	and funding_approval_status_cd is null
	and payment_approval_status_cd is null ;

update tb_service_purchase_authorization 	
set delete_sw = 'Y',
	update_ts = now(), 
	update_user_id = 'CDM-23378'
where authorization_id in ( 1832871, 1832872 )
	and delete_sw = 'N'
	and sprvsr_approval_status_cd is null
	and ads_approval_status_cd is null
	and funding_approval_status_cd is null
	and payment_approval_status_cd is null ;