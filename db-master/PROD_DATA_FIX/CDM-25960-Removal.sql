/*
   Issue Description: CDM-25960
   Category/ Module  : Removal 
   Root cause: user requeseted to remove duplicate removal 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update cjams.intakeservreqchildremoval set activeflag =0, updatedby ='CDM-25960', updatedon =now()
where intakeservreqchildremovalid ='a917f43a-e9b2-4639-9334-db66712acb88';


update placement set intakeservreqchildremovalid = '21983e25-51be-441a-ae80-0a1b6568d720', updatedby = 'CDM-25960', updatedon = now() 
where placementid ='24e42432-a4b3-4f26-b06e-c07310387606';


update tb_client_eligibility set delete_sw = 'Y', update_user_id = 'CDM-25960', update_ts = now() 
where removal_id = '254237';