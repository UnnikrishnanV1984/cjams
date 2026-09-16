/*
  Issue Description:CDM-39871 Unable to end date service logs
                    3308146:I am unable to end date service logs which prevents me from closing this case out
  Category/ Module :Approval
  Root cause: Service Log end date is missing which is preventing the user to close the case.
  Fix Provided: Data fix has been provided to endate the service log for the case 3308146 to 08/04/2023
  Pull request# for code fix: N/A
  Reason why no related code fix: N/A
  Status of the code fix if already submitted and expected prod fix date: N/A
  Backup before update/ delete: N/A
*/

update tb_service_log
  	set end_dt = '2023-08-04'::date, end_service_reason_cd = '1824', update_ts = now(), update_user_id = 'CDM-39871' 
  	where service_log_id = 2530029
  		and case_id =  3308146
  		and client_id = 4447972
  		and end_dt is null;