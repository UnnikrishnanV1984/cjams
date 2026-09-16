/*
Root Cause: User requested to reopen the youth
Fix Provided: Fix Provided by reopen the requested youth
Code Fix: No
*/

update tb_client_account
set status_cd = '592',
close_dt = null,
final_close_dt = null,
update_user_id = 'CJAMS-66532',
update_ts = now()
where client_account_id = '14583'
and delete_sw = 'N';