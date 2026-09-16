-- CDM-18909 - Duplicate PA
/*
-- Issue Description: 
   To delete duplicate purchase authorization 
   
-- Case ID: 3142145
-- Client ID: 200172693	(Dont'A	Christopher Paetin Epps) - 50a6a265-7720-4426-b852-0bdc71b03445
-- Service Log ID: 2022915 - 2021-12-03 To Current - Rent Payments/Deposit (Paid)  
-- Provider ID: 6004827	(R & R Recovery, LLC) 
-- Authorization ID: 1807144

-- Category/ Module: Service Log/Purchase Authorization (Case Management) 
-- Root cause: User error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Soft_delete the requested Duplucate Service Purchase Authorization
select service_log_id, start_dt, end_dt, delete_sw, update_ts, update_user_id 
	from tb_service_purchase_authorization 
where authorization_id = 1807144
	and delete_sw = 'N'
	and sprvsr_approval_status_cd is null
	and ads_approval_status_cd is null
	and funding_approval_status_cd is null
	and payment_approval_status_cd is null ;

update tb_service_purchase_authorization 	
set delete_sw = 'Y',
	update_ts = now(), 
	update_user_id = 'CDM-18909'
where authorization_id = 1807144
	and delete_sw = 'N'
	and sprvsr_approval_status_cd is null
	and ads_approval_status_cd is null
	and funding_approval_status_cd is null
	and payment_approval_status_cd is null ;

