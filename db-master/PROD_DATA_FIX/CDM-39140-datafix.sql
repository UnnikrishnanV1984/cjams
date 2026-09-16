/* 
    Issue Description: CDM-39140
   Category/ Module  : SDM
   Root cause: Modified the fiscal category code to 7142 from 7134.
   Pull request# for code fix: N/A
   Reason why no related code fix: N/A
   Status of the code fix if already submitted and expected prod fix date: N/A
    
*/

update tb_service_purchase_authorization 
set fiscal_category_cd = '7142' ,
    update_ts= now(),
    update_user_id= 'CDM-39140'
where authorization_id = 2292665
    and delete_sw= 'N'
    and btrim(fiscal_category_cd) ='7134';


/*----------------------------Payment ID----------------------------------------------*/

update cjams.tb_payment_detail
set final_fiscal_category_cd='7142',
    update_ts = now(),
    update_user_id='CDM-39140'
where payment_id = 677714
   and delete_sw='N'
   and btrim(final_fiscal_category_cd) ='7134';
  
