/*
Issue Description: There is an overlapping service logs and data fix is needed to ended the service log.
Category/ Module: Bug
Root cause: Two service logs had no end date and were causing issues with closing the case.
Fix provided: Yes, write DB query.
Code fix ticket#: CDM-39961
Reason why no related code fix: Status of the code fix already submitted 
Status of the code fix if already submitted and expected prod fix date: 
void the rejected provider placement from backend
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update tb_service_log
set
	end_dt = '2023-09-26',
	end_service_reason_cd = '1824',
	update_ts = now(), 
	update_user_id = 'CDM-39961'
where service_log_id = 2012840;

update tb_service_log
set
	end_dt = '2021-12-17',
	end_service_reason_cd = '1824',
	update_ts = now(), 
    update_user_id = 'CDM-39961'
where service_log_id = 978638;
