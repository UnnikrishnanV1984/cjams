/*
   Issue Description: CDM-30046
   Category/ Module  :  child removal
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   */

update intakeservreqchildremoval
 set activeflag =0, 
 updatedby ='CDM-30046' ,
 updatedon =now() 
 where removalid = '252744';

 update personprogramarea set activeflag =0,updatedby ='CDM-30046' ,
 updatedon =now()  where personprogramid = '74a23c06-6d6c-4328-9900-ba87e393ee66';

 
update tb_client_eligibility
set delete_sw = 'Y',
	update_user_id = 'CDM-30046',
	update_ts = now()
where removal_id = 252744
	and eligibility_status_cd = '2909'
	and delete_sw  = 'N' ;

update routing set activeflag = 0,
updatedby ='CDM-30046' ,
updatedon =now() 
where objectid = '96184279-6097-4bc6-9742-af4eb6b809f0';    