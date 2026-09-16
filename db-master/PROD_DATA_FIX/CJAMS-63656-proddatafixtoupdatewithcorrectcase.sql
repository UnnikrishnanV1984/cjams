/*
   Issue Description: CJAMS-63656
   Category/ Module  : Prod data fix to update with correct case id
   Root cause:  
   Pull request# for code fix:
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/





update tb_client_eligibility set case_id = '221030017445', update_user_id = 'CJAMS-63656',update_ts = now()
where client_id = '3367186' and removal_id = '254349' and case_id = '3230454';