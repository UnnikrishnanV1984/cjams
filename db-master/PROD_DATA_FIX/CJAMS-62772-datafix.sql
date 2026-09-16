/* 
    Issue Description: CJAMS-62772
  Category/ Module  : Services: Service Log
  Root cause: User request to update/change the Purchase Auth# 3878704 End date to "08/31/2025". The same need to be updated on the PDF download as well.
  Fix provided: Data fix has been applied to modify the purchase authorization date
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date: N/A
  Backup before update/ delete: 
*/

update tb_service_purchase_authorization
SET end_dt='2025-08-31', 
    update_user_id='CJAMS-62772',
    update_ts =now() 
where service_log_id ='3781357';


UPDATE cjams.tb_slpa_snapshot
SET end_dt='2025-08-31', 
    update_user_id='CJAMS-62772',
    update_ts =now() 
WHERE authorization_id  = '3878704';

UPDATE cjams.tb_payment_detail
set final_service_end_dt ='2025-08-31',update_user_id ='CJAMS-62772', update_ts =now()
where  payment_id ='4847402' and  delete_sw='N' and payment_detail_id ='6129769' ;