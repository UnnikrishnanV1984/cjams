/*
   Issue Description: CIDM-7999
   Category/ Module  : Prod data fix to update IVE Referrals Data
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/



update tb_client_eligibility set start_dt = '2023-06-22', update_ts = now(), update_user_id = 'CIDM-7999'
where removal_id = '277940';