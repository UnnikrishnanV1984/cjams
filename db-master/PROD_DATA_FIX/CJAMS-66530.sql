/*
   Issue Description: CJAMS-66530
   Category/ Module:  child account reopen
   Root Cause: User requested to reopen the client's accounts (4165756, 4002771)
   Fix provided: Data fix has been done by reopening the client's accounts (4165756, 4002771) as requested
*/

update tb_client_account
set status_cd = '592',
close_dt = null,
final_close_dt = null,
update_user_id = 'CJAMS-66530',
update_ts = now()
where client_account_id = '13007'
and delete_sw = 'N';

update tb_client_account
set status_cd = '592',
close_dt = null,
final_close_dt = null,
update_user_id = 'CJAMS-66530',
update_ts = now()
where client_account_id = '15304'
and delete_sw = 'N';