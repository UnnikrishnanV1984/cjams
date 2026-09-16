/*
   Issue Description: CDM-18072
   Category/ Module  : Voiding a placement
   
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update placement  set isvoided  = 1, updatedon = now(), updatedby = 'CDM-18072' where placementid = 'bea50a56-a2fa-40e8-9fa2-d7515a894e7d';
update placementrevision  set isvoided  = 1, updatedon = now(), updatedby = 'CDM-18072' where placementid = 'bea50a56-a2fa-40e8-9fa2-d7515a894e7d';
update tb_placement_validation set delete_sw  = 'Y', update_ts = now(), update_user_id = 'CDM-18072'  where placement_id = '1561427';