/*
-- Issue Description: unable to complete any payments 
    Case# 251030486071
    Client ID: 201305944 (Destiny Whitely)
    Provider ID: 5034072 (Prince George's County DSS)
    Service Name: Financial Management (Paid)
    Purchase Authorization ID: 3831028
    Payment ID: 4796582
-- Category/ Module: Service Log (Case Management) 
-- Root cause: User error.  
-- Fix Provided: Datafix has been promoted to update the  Purchase Authorization (3831028) end date from "06/30/2026" to "08/02/2025".
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

--select *, authorization_id from tb_service_purchase_authorization tspa where authorization_id = 3831028;

UPDATE cjams.tb_service_purchase_authorization
SET end_dt='2025-08-02', 
	update_user_id='CJAMS-62104',
	update_ts =now() 
WHERE authorization_id  = 3831028;

/*
select final_service_start_dt, final_service_end_dt, * from tb_payment_detail 
where  delete_sw = 'N' and client_id ='201305944'
and final_service_end_dt = '2025-12-03'
*/

update tb_payment_detail
set final_service_end_dt = '2025-08-02',
	update_user_id='CJAMS-62104',
	update_ts =now() 
where payment_id = 4796582 and payment_detail_id = 6068075;

--select end_dt ,* from tb_slpa_snapshot where authorization_id  = 3831028;

UPDATE cjams.tb_slpa_snapshot
SET end_dt='2025-08-02', 
	update_user_id='CJAMS-62104',
	update_ts =now() 
WHERE authorization_id  = 3831028;