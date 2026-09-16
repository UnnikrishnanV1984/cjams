/*
   Issue Description: CDM-38817
   Category/ Module  : Prod data fix to remove Duplicate record from IVE dashboard
   Root cause: Record inserted with incorrect RemovalID 
   Pull request# for code fix:  CIDM-5517
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/



 update tb_client_eligibility  set delete_sw = 'Y', update_user_id = 'CDM-38817', update_ts = now()  where eligibility_id = '10004674' and delete_sw = 'N' ;