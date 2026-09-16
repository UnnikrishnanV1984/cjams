
/*
   Issue Description: CDM-43792
   Category/ Module  :  Child Removal History and Program
   Root cause: user requeseted to remove child removal and update placement and child removal end date
   Pull request# for code fix: 
   Reason why no related code fix: User Error
   Status of the code fix if already submitted and expected prod fix date: 
*/


update intakeservreqchildremoval 
set activeflag = 0, updatedon =now(),updatedby ='CDM-43792' 
where  intakeservreqchildremovalid = 'c9bcb723-3e9d-400c-ba84-24aad8f8544f' and activeflag =1;

update intakeservreqchildremoval 
set exitdate  = null, updatedon =now(),updatedby ='CDM-43792' 
where  intakeservreqchildremovalid = '3d88f111-c3d2-4668-a855-33c00a9e3675' and activeflag =1;

update intakeservreqchildremoval_history 
set activeflag = 0,updatedon =now(),updatedby ='CDM-43792' 
where  intakeservreqchildremovalid = 'c9bcb723-3e9d-400c-ba84-24aad8f8544f' and activeflag =1;

update personprogramarea 
set enddate = null,updatedon =now(),updatedby ='CDM-43792' 
where  personprogramid ='18d88db7-d1c1-4a9d-8ed2-12904c61344a' and activeflag =1;

update placement
set exittypekey = 'CIPS', updatedby = 'CDM-43792', updatedon = now()
where placementid = '5509205c-b920-4496-97de-058d5793c1f2' and activeflag = 1;

update placementrevision
set exittypekey = 'CIPS', updatedby = 'CDM-43792', updatedon = now()
where placementrevisionid = 'a7d6ab6d-67cb-47f4-9fc2-7c9c904fa6c8' and activeflag = 1;
