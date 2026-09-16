-- CDM-18149 - multiples of same payments
/*
-- Issue Description: 
   To delete duplicate purchase authorizations 
   
-- Case ID: 3162272
-- Client ID: 2277311 (TA'NIYA RENEE SIMMS) - d223c8fc-77ad-4766-ba8a-adc8dcd057ed
-- Service Log ID: 1982223 - 2020-08-02 To Current - Transportation assistance (Paid) 
-- Provider ID: 5007433	(EMILY PINKNEY) 
-- Authorization IDs: 1802564, 1802565, 1802566, 1802567, 1802568, 1802569, 1802570

-- Approval is In_progess for Auth ID: 1802571

-- Category/ Module: Service Log/Purchase Authorization (Case Management) 
-- Root cause: User error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Soft_delete the requested Duplucate Service Purchase Authorization
select service_log_id, start_dt, end_dt, delete_sw, update_ts, update_user_id 
	from tb_service_purchase_authorization 
where authorization_id 
		in (1802564, 1802565, 1802566, 1802567, 1802568, 1802569, 1802570)
	and delete_sw = 'N'
	and sprvsr_approval_status_cd is null
	and ads_approval_status_cd is null
	and funding_approval_status_cd is null
	and payment_approval_status_cd is null ;

update tb_service_purchase_authorization 	
set delete_sw = 'Y',
	update_ts = now(), 
	update_user_id = 'CDM-18149'
where authorization_id 
		in (1802564, 1802565, 1802566, 1802567, 1802568, 1802569, 1802570)
	and delete_sw = 'N'
	and sprvsr_approval_status_cd is null
	and ads_approval_status_cd is null
	and funding_approval_status_cd is null
	and payment_approval_status_cd is null ;
