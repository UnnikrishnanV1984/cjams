-- CDM-425 - Approved payments for Baltimore City

--already executed in PROD

/*select payment_id, payment_status_cd, payment_status_dt, update_ts
from tb_payment_status where payment_id = 1943315 and delete_sw = 'N' ;

update tb_payment_status
set payment_status_cd = '1634',
payment_status_dt = '2020-02-21'::date,
update_ts = current_timestamp
where payment_id = 1943315
and delete_sw = 'N' ;

select payment_id, payment_status_cd, payment_status_dt, update_ts
from tb_payment_status where payment_id = 1943315 and delete_sw = 'N' ;
*/