/* 
    Issue Description: CDM-34300
   Category/ Module  : unable to add provider placement
   Root cause: user getting 'Something went wrong' error message while trying to send placemnt for approval
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/

update prov.tb_contract_program 
set row_lock =null,
update_user_id ='CDM-34340',
update_ts =now() 
where program_id=1397 and contract_id ='50000163';