/* 
   Issue Description: CDM-40434
   Category/ Module  : SDM
   Root cause: Modified the fiscal category code to 7121 from 7133.
   Pull request# for code fix: N/A
   Reason why no related code fix: N/A
   Status of the code fix if already submitted and expected prod fix date: N/A
    
*/

update tb_service_purchase_authorization 
set fiscal_category_cd = '7121' ,
    update_ts= now(),
    update_user_id= 'CDM-40434'
where authorization_id = 3123426
    and delete_sw= 'N'
    and btrim(fiscal_category_cd) ='7133';


/*----------------------------Payment ID----------------------------------------------*/

update cjams.tb_payment_detail
set final_fiscal_category_cd='7121',
    update_ts = now(),
    update_user_id='CDM-40434'
where payment_id = 4433782
   and delete_sw='N'
   and btrim(final_fiscal_category_cd) ='7133';
  
