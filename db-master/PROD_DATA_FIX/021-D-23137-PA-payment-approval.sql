update tb_service_purchase_authorization set funding_approval_status_cd='3047',funding_approval_dt='2020-01-08',update_ts=current_timestamp where authorization_id=1730925 and service_log_id=939359;
update routing set tosecurityusersid='753c40c4-34fd-4e88-9e2a-f974a416d51a',updatedon=current_timestamp where routingid='8f5a7481-4c63-4337-9024-3f63810cf9f4';
delete from routing where routingid in ('6a8a9111-49bc-49f9-ae81-dc2ef411598b','f7c2872b-9ad4-4c4b-b9e4-b6ac9eeaba37');
update routing set tosecurityusersid='753c40c4-34fd-4e88-9e2a-f974a416d51a',updatedon=current_timestamp where routingid='5351a804-a059-4f02-9063-66d49e8fcc96';
