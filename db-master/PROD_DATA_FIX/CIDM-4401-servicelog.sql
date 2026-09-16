 /*
  Issue Description: CIDM-4401 Future end date - Service log
   Category/ Module  :  service log 
   Root cause:
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: start_dt='20252-03-09' , end_dt='20252-03-09'
*/

update cjams.TB_service_log set start_dt='2022-03-09' , end_dt='2022-03-09', update_ts=now(), update_user_id='CIDM-4401'
where service_log_id = 2037628;