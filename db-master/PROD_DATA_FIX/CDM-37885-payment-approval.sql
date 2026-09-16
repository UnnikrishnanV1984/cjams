-- CDM-37885
/*
-- Root cause: Purchase auth was submitted for Funding Approval but it is not available for any Finance supervisor.
-- Fix Provided: data fix done to appear in filter page.
*/


select authorization_id, 
	sprvsr_approval_status_cd,
	sprvsr_approval_dt,
	ads_approval_status_cd,
	ads_approval_dt,
	funding_approval_status_cd, 
	funding_approval_dt, 
	payment_approval_status_cd,
	payment_approval_dt,
	update_ts, 
	update_user_id
from tb_service_purchase_authorization 
where authorization_id = 3021659
	and delete_sw = 'N'
	and payment_approval_status_cd is null ;

--UPDATE cjams.tb_service_purchase_authorization
--SET sprvsr_approval_status_cd='3047', sprvsr_approval_dt='2024-03-12', ads_approval_status_cd='3047', ads_approval_dt='2024-03-12', funding_approval_status_cd='3047', funding_approval_dt='2024-02-21', payment_approval_status_cd=NULL, payment_approval_dt=NULL, update_ts='2024-03-12T13:44:09.451Z', update_user_id='ba2dbc8f-3213-4b1b-9905-d643e1692db1'
--WHERE authorization_id=3021659;

update tb_service_purchase_authorization 	
set funding_approval_status_cd = NULL,
	funding_approval_dt = NULL,
	update_ts = now(), 
	update_user_id = 'CDM-37885'
where authorization_id = 3021659
	and delete_sw = 'N'
	and payment_approval_status_cd is null ;