/* 
    Issue Description : CJAMS-66223
    Category/ Module : Placement
    Root cause :Getting Error message "something went wrong" when trying to enter provider
*/


update tb_contract_program
set row_lock = null, update_user_id ='CJAMS-66223', update_ts = now()
where  program_id  = 4824 and  delete_sw='N';




