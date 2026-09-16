 /*
  Issue Description: CDM-17209
   Category/ Module  :  Updating end date 
   Root cause: user asked to update it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

-- 2021-09-30
update tb_fiscal_category_master set end_dt = '2021-09-30', update_ts = now() , update_user_id= 'CDM-17209' where fiscal_category_cd = '5121';