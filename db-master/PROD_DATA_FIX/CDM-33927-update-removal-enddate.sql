/*
   Issue Description: CDM-33927
   Category/ Module  : child removal, Person programarea,Placement
   Root cause: User requested to update child removal date
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/




update intakeservreqchildremoval set exitdate ='2023-07-11 09:00:00' ,updatedby ='CDM-33927',updatedon =now() where intakeservreqchildremovalid ='22c003cd-4703-40eb-9253-adb57aae5528';

update personprogramarea set enddate ='2023-07-11 00:00:00',updatedby ='CDM-33927',updatedon =now() where personprogramid='93ab995c-361f-47f6-b443-c450cac72ffb';

update tb_client_eligibility
set
   end_dt = '2023-07-11',
   update_user_id = 'CDM-33927',
   update_ts = now()
where removal_id = '190538';


update livingarrangement set livingenddate = '2023-07-11 00:00:00',updatedby ='CDM-33927',updatedon =now() where placementid ='f9dbce4b-3e7f-400c-8760-e003f3d9c922';


update placement set enddatetime = '2023-07-11 00:00:00',updatedby ='CDM-33927',updatedon =now() where placementid ='f9dbce4b-3e7f-400c-8760-e003f3d9c922';