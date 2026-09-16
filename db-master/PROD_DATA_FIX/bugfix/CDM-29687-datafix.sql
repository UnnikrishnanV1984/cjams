/*
   Issue Description: CDM-29687
   Category/ Module  : Personal Cell Phone # on Documents
   Root cause:My personal cell phone number is showing when I complete a SERVICE LOG under SERVICES tab.
   Pull request# for code fix: It's a data fix
   Reason why no related code fix:  
   
*/


update userprofilephonenumber set phonenumber = '2403297766', updatedby = 'CDM-29687', updatedon = now() where userprofilephonenumberid = '1c25a24a-86f8-4aab-aa60-d053ce647f32';


update tb_slpa_snapshot set worker_phone = '(240) 329-7766' , 
requestor_phone = '(240) 329-7766', update_ts = now(), update_user_id = 'CDM-29687' where authorization_id = 2057215;
