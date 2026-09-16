/*
-- Issue Description: 
We are not able to close this case due to outstanding purchase authorizations that we are not able to locate in CJAMS. 
Purchase Authorizations: This provider cannot be closed until all outstanding purchase authorizations (( Case ID: 3088691, Auth ID: 741089, Date: 2019-12-01 )) have received payment approval. --  Case# 3299565, Client ID: 4040404 (TASHAMERE CARTER), 
-- Category/ Module: Service Log (Case Management) 
-- Root cause: Partial migration data issue.  
-- Fix Provided: Datafix has been promoted to update the missing values.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

/*
 select authorization_id,update_user_id , service_log_id, sprvsr_approval_status_cd, sprvsr_approval_dt,
    ads_approval_status_cd, ads_approval_dt,
    funding_approval_status_cd, funding_approval_dt,
    payment_approval_status_cd, payment_approval_dt
    ,final_amount_no
from tb_service_purchase_authorization 
where authorization_id = 741089 ;

select approval_status_cd ,update_ts ,* from tb_payment_header tpd where authorization_id ='741089';
*/

 update tb_service_purchase_authorization
 set sprvsr_approval_dt='2020-01-06',
    ads_approval_status_cd = '3047',
    ads_approval_dt = '2020-01-08',
    funding_approval_status_cd = '3047',
    funding_approval_dt = '2020-01-16',
    payment_approval_status_cd = '3047',
    payment_approval_dt = '2020-01-16',
    final_amount_no = 903.96,
    update_ts = now(),
    update_user_id = 'CJAMS-60202'
where authorization_id = 741089 ;

--select insertedon ,routingstatustypeid ,remarks ,* from routing r where objectid ='741089' order by updatedon desc;

update routing 
set insertedon = '2020-01-16 11:05:14.000',--2025-06-11 08:14:13.580
	updatedon =  now(), --2025-06-11 08:14:13.580
	updatedby = 'CJAMS-60202'
where routingid = '5f7f7811-cd1f-4ac4-ac91-67523ac1628f' and objectid ='741089';

--select payment_approval_dt,payment_staff_id ,payment_name ,funding_staff_id ,funding_name ,funding_title ,* from tb_slpa_snapshot tss where authorization_id in ('741089','1731659')

update tb_slpa_snapshot 
set payment_staff_id = 200001342,
	payment_name = 'Lajuanda Swett-Kane',
	update_ts = now(),
	update_user_id = 'CJAMS-60202'
where slpa_snapshot_id =310812
and authorization_id = 741089
and delete_sw = 'N';