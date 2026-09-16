/*
   Issue Description: CDM-27439
   Category/ Module  : Child Removal/Placement
   Root cause: user wants to remove end date,
   Adoption subsidy for David Spears III cannot begin due to adoptive parents not populating
   Pull request# for code fix: 7338
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
     --child end date: 11/16/2022
*/

update intakeservreqchildremoval set exitdate = null, updatedon = now(), updatedby = 'CDM-27439'
where intakeservreqchildremovalid = '938fb1ef-5f57-4cc9-ad95-4a04f7073935';

update personprogramarea set enddate = null, updatedby = 'CDM-27439', updatedon = now() 
where personprogramid = '8b24f69c-4186-4c51-b4c9-6471dc55e8c1';

update tb_client_eligibility
set end_dt = null,
    update_user_id = 'CDM-27439',
    update_ts = now()
where removal_id = 251962;
