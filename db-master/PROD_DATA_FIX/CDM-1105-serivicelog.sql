update tb_service_log set delete_sw='Y' where case_id=3273341 and start_dt='2020-09-01' and service_log_id=1957317;

update tb_service_purchase_authorization set delete_sw='Y' where service_log_id='1957317' and authorization_id=1733497;

update routing set activeflag=0 where objectid=1733497 and routingid='119d9f9d-5b0d-46a0-91c0-4314b67a62f7';