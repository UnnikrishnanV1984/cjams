/* 
Issue Description: CJAMS-68259
Category/ Module  : Services: Service Log
Root cause: Requested for a data fix to remove service logs
Fix provided: Data fix has been done to remove service logs
Is code fix required: N 
Pull request# for code fix: 
Reason why no related code fix: 
Status of the code fix if already submitted and expected prod fix date: N/A
Backup before update/ delete: 
 */
----Provider ID 6002434 / Authorization ID - 4422905--
update tb_service_purchase_authorization
set
  delete_sw = 'Y',
  update_user_id = 'CJAMS-68259',
  update_ts = now ()
where
  service_log_id = '4224956'
  and authorization_id = '4422905'
  and sprvsr_approval_status_cd is null
  and ads_approval_status_cd is null
  and funding_approval_status_cd is null
  and payment_approval_status_cd is null;

---Provider ID 6002434 / Authorization ID - 4422900--
update tb_service_purchase_authorization
set
  delete_sw = 'Y',
  update_user_id = 'CJAMS-68259',
  update_ts = now ()
where
  service_log_id = '4222650'
  and authorization_id = '4422900'
  and sprvsr_approval_status_cd is null
  and ads_approval_status_cd is null
  and funding_approval_status_cd is null
  and payment_approval_status_cd is null;

---Authorization IDs 1845739,1845738,1845736 
update tb_service_purchase_authorization
set
  delete_sw = 'Y',
  update_user_id = 'CJAMS-68259',
  update_ts = now ()
where
  service_log_id = '2053035'
  and authorization_id in ('1845739', '1845738', '1845736')
  and sprvsr_approval_status_cd is null
  and ads_approval_status_cd is null
  and funding_approval_status_cd is null
  and payment_approval_status_cd is null;

---Authorization IDS 1854910,1854909,1854908,1854907,1854906,1854905,1854903
update tb_service_purchase_authorization
set
  delete_sw = 'Y',
  update_user_id = 'CJAMS-68259',
  update_ts = now ()
where
  service_log_id = '2059808'
  and authorization_id in (
    '1854910',
    '1854909',
    '1854908',
    '1854907',
    '1854906',
    '1854905',
    '1854903'
  )
  and sprvsr_approval_status_cd is null
  and ads_approval_status_cd is null
  and funding_approval_status_cd is null
  and payment_approval_status_cd is null;

---1895843
update tb_service_purchase_authorization
set
  delete_sw = 'Y',
  update_user_id = 'CJAMS-68259',
  update_ts = now ()
where
  service_log_id = '2101859'
  and authorization_id = '1895843'
  and sprvsr_approval_status_cd is null
  and ads_approval_status_cd is null
  and funding_approval_status_cd is null
  and payment_approval_status_cd is null;