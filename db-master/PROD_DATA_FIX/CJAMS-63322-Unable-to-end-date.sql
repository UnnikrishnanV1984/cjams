/* 
    Issue Description: 3272038:Unable to end date service log. Need an end date of 8/19/25 to close case. 
   Category/ Module  : Service Log End date  Error
   Root cause:  As per system design, the service log can not be ended prior to the latest purchase authorization end date and beyond the selected client program date period.
   In this case, the client program is ended prior to the latest purchase authorization end-date in the service log. So data fix is needed to ended the respective open service log with 08/31/2025.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    void the rejected provider placement from backend
*/

update tb_service_log
set end_dt = '08-31-2025',
    update_ts = now(), 
	update_user_id = 'CJAMS-63322',
    end_service_reason_cd= '1824'  
where service_log_id ='3765282'
and delete_sw = 'N';