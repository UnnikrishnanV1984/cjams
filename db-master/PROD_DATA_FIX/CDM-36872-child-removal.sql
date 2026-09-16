/*
   Issue Description: CDM-36872
   Category/ Module  : child removal, Person programarea,Placement
   Root cause: User requested to update child removal date and remove the entire removal
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

select exitdate ,* from intakeservreqchildremoval where intakeservreqchildremovalid='32c6554a-e989-4d5e-a2b1-34af6a688a7c';

update intakeservreqchildremoval 
set exitdate = null ,returntransts= null ,updatedby ='CDM-36872',updatedon =now() 
where intakeservreqchildremovalid ='32c6554a-e989-4d5e-a2b1-34af6a688a7c';

select * from personprogramarea where personprogramid = 'b0b28916-e044-4ff7-9a73-27a1dd4385da';

update personprogramarea
set enddate = null,updatedby ='CDM-36872',updatedon =now()
where personprogramid='b0b28916-e044-4ff7-9a73-27a1dd4385da';

select * from tb_client_eligibility where removal_id = '299057';

update tb_client_eligibility
set
   end_dt = null,
   update_user_id = 'CDM-36872',
   update_ts = now()
where removal_id = '299057';


------------------------------------------------------------------


select * from intakeservreqchildremoval where intakeservreqchildremovalid = '603b9169-309f-450e-9589-317582db965e';

update intakeservreqchildremoval 
set activeflag  = 0 , updatedby ='CDM-36872',updatedon =now() 
where intakeservreqchildremovalid ='603b9169-309f-450e-9589-317582db965e';

select * from personprogramarea where personprogramid  = '2c5fb5d0-316a-47f8-8606-43bc79a7f18d';

update personprogramarea
set activeflag = 0,updatedby ='CDM-36872',updatedon =now()
where personprogramid='2c5fb5d0-316a-47f8-8606-43bc79a7f18d'; 

select * from tb_client_eligibility where removal_id = '299487';

update tb_client_eligibility
set
   delete_sw  = 'Y',
   update_user_id = 'CDM-36872',
   update_ts = now()
where removal_id = '299487';