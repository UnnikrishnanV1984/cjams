/*
-- Issue Description: 
251030486071:Good Morning, Worker is unable to add service log via the provider, Prince George's County DSS due to the prior service having an end date of June 2026.
    Client ID: 201305942 (Destine Whitely)
    Provider ID: 5034072 (Prince George's County DSS)
    Service: Financial Management (Paid)
    Auth ID: 3831038
    Auth End Date: 06/30/2026
-- Category/ Module: Service Log (Case Management) 
-- Root cause: User error.  
-- Fix Provided: Datafix has been promoted to update the requested Service Log End dates , Actual End date and Purchase Authorization End date to "08/31/2025".
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

/*
select *, authorization_id from tb_service_purchase_authorization tspa where service_log_id = 1991182;
*/
/*update tb_service_purchase_authorization table with authorization_id = 3831038
(There can be multiple authorizations for the same service_log_id )
*/
UPDATE cjams.tb_service_purchase_authorization
SET end_dt='2025-08-31', 
	update_user_id='CJAMS-62430',
	update_ts =now() 
WHERE authorization_id  = 3831038;

/*payment table --> tb_payment_detail -> final_service_end_dt 
select final_service_start_dt, final_service_end_dt, * from tb_payment_detail 
where final_service_end_dt = '2026-07-31' and final_service_start_dt = '2025-08-31' 
and client_id = 4040404 
and case_id = 3299565;
*/
-- payment_id = 3035311;
--select final_service_end_dt,final_service_start_dt,* from tb_payment_detail where client_id = '201305942' and delete_sw ='N';

update tb_payment_detail
set final_service_end_dt = '2025-08-31',
	update_user_id='CJAMS-62430',
	update_ts =now() 
where payment_id = 4796581
	and payment_detail_id = 6068074 ;

/*
 * update PDF
select * from tb_slpa_snapshot where authorization_id  = 3831038;
*/

UPDATE cjams.tb_slpa_snapshot
SET end_dt='2025-08-31', 
	update_user_id='CJAMS-62430',
	update_ts =now() 
WHERE authorization_id  = 3831038;