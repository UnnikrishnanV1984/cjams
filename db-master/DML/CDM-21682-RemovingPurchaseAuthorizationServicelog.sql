/*
   Issue Description: CDM-21682
   Category/ Module  :  Removing Service Log in Purchase Authorization
   Root cause: Removing Service Log in Purchase Authorization
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update tb_service_purchase_authorization set delete_sw = 'Y', update_ts= now()::character varying ,update_user_id = 'CDM-21682'  where authorization_id = '1818401';
