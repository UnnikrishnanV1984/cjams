/*
   Issue Description: CDM-35869
   Category/ Module  : child removal, Person programarea,Placement
   Root cause: User requested to update child removal date
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/



update intakeservreqchildremoval 
set exitdate = null ,returntransts= null ,updatedby ='CDM-35869',updatedon =now() 
where intakeservreqchildremovalid ='8472f353-864e-4560-98cf-3eb82819e4e8';

update personprogramarea
set enddate = null,updatedby ='CDM-35869',updatedon =now()
where personprogramid='fcbabd70-c08a-4d93-a475-653c4eae781e';

update tb_client_eligibility
set
   end_dt = null,
   update_user_id = 'CDM-35869',
   update_ts = now()
where removal_id = '200028';