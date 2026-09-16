/* 
   Issue Description: CJAMS-59004
   Category/ Module  : Purchase Auth
   Root cause: Modified the fiscal category code to 7115 from 7133.
   Pull request# for code fix: N/A
   Reason why no related code fix: N/A
   Status of the code fix if already submitted and expected prod fix date: N/A
    
*/

/*
select fiscal_category_cd ,* from tb_service_purchase_authorization where authorization_id in(
3701888,
3721177,
3707972,
3740381
) --7133

select fiscal_category_cd ,* from tb_fiscal_category_master tfcm where fiscal_category_cd in ('7133','7115')
*/

update tb_service_purchase_authorization 
set fiscal_category_cd = '7115' ,
    update_ts= now(),
    update_user_id= 'CJAMS-59004'
where authorization_id in(
	3701888,
	3721177,
	3707972,
	3740381
	) --7133 
	and delete_sw= 'N'
    and btrim(fiscal_category_cd) ='7133';
     
/*-------------Payment ID--------------------*/
 
/*select * from tb_payment_header tph where authorization_id in 
(
3701888,
3721177,
3707972,
3740381
);*/ --7133

update cjams.tb_payment_detail
set final_fiscal_category_cd='7115',
    update_ts = now(),
    update_user_id='CJAMS-59004'
where payment_id in (
4647951,
4667143,
4687245,
4699291)
and delete_sw='N'
and btrim(final_fiscal_category_cd) ='7133';
  
--snap table 
update tb_slpa_snapshot 
set fiscal_category_cd = '7115',
	fiscal_category_desc = 'IRC Rate Educational Expense',
    update_ts= now(),
    update_user_id = 'CJAMS-59004'
where authorization_id in(
	3701888,
	3721177,
	3707972,
	3740381
	) --7133 
	and delete_sw= 'N'
    and btrim(fiscal_category_cd) ='7133';