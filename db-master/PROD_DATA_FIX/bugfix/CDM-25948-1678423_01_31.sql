/*
   Issue Description: CDM-25948
   Category/ Module  : Delete the dat with requested 
   Root cause: .
   Pull request# for code fix: It's a data fix   
*/


update tb_placement_validation 
set delete_sw = 'Y', 
update_user_id = 'CDM-25948', update_ts = now()  
where placement_validation_id in ('1977763', '1977762');