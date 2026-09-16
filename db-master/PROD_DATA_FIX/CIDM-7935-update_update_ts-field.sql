/*
In tb_provider table some values are of update_ts is wrongly saved as text 'now()'instead of  timestamp
*/

update prov.tb_provider  set update_ts =now(), update_user_id ='CIDM-7935'  where update_ts = 'now()';