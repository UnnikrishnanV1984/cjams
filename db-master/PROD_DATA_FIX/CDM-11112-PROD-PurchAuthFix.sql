update tb_service_purchase_authorization
set delete_sw ='Y', update_ts =current_timestamp, update_user_id='CDM-11112'
where authorization_id =1766126;

update routing 
set activeflag =0, updatedon=now(), updatedby='CDM-11112'
where objectid=1766126;