/*
   Issue Description: CDM-33265
   Category/ Module  :  child removal
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   */

update intakeservreqchildremoval
 set activeflag =0, 
 updatedby ='CDM-33265' ,
 updatedon =now() 
 where removalid = '278837';

 update personprogramarea set activeflag =0,updatedby ='CDM-33265' ,
 updatedon =now()  where personprogramid = 'a22c2a61-93c8-4eba-8434-b32ea9a01f79';

 
update tb_client_eligibility
set delete_sw = 'Y',
	update_user_id = 'CDM-33265',
	update_ts = now()
where removal_id = 278837
	and eligibility_status_cd = '2909'
	and delete_sw  = 'N' ;

update routing set activeflag = 0,
updatedby ='CDM-33265' ,
updatedon =now() 
where objectid = 'b55f4408-345c-444b-9d54-f0b2482881ee';    