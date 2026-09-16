
/*
   Issue Description: CDM-17688
   Category/ Module  : Updating Service log records
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

-- 2021-10-31	2021-10-31	2008489
-- 2023-10-21	2023-10-21	959786
-- 2023-06-04	2023-06-04	926386
update tb_service_log set end_dt = '2021-09-30',
estimated_end_dt = '2021-09-30', update_user_id = 'CDM-17688', update_ts = now() 
where service_log_id in (2008489,959786,926386);