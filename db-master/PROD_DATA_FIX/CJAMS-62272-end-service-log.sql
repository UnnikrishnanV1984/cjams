/*
Issue Description:CJAMS-62272 Case Closure
Category/Module: Service log
Root cause: As per system design, the service log can not be ended prior to the latest purchase authorization end date and beyond the selected client program date period.

In this case, the client program is ended prior to the latest purchase authorization end-date in the service log. So data fix is needed to ended the respective open service log with 09/13/2023.
case 221030015552 with client id: 200847464  and provider id: 028161 
Fix provided: Data fix has been done to end date the service log date to 09/13/2023 for the case 221030015552 with client id: 200847464  and provider id: 028161 
Data/Code fix ticket#:CJAMS-62272
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/


update tb_service_log
set end_dt= '2023-09-13',
	estimated_end_dt = '2023-09-13',
	end_service_reason_cd = '1824',
	update_ts= now(),
	update_user_id = 'CJAMS-62272'
where 	client_id=200847464 
	and service_log_id=2583198
