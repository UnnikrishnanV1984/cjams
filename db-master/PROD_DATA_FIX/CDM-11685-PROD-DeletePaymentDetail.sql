update tb_payment_detail 
set delete_sw ='Y', update_ts =current_timestamp, update_user_id='CDM-11685'
where payment_detail_id =2859107;

update tb_payment_header 
set delete_sw ='Y', update_ts =current_timestamp, update_user_id='CDM-11685'
where payment_id =1810966;

update tb_payment_status 
set delete_sw ='Y', active_sw ='N', update_ts =current_timestamp, update_user_id='CDM-11685'
where payment_status_id =1809619;