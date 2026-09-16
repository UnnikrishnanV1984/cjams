/*
   Issue Description: CDM-27645
   Category/ Module  : Personal Cell Phone # on Documents
   Root cause:My personal cell phone number is showing when I complete a SERVICE LOG under SERVICES tab.
   Pull request# for code fix: It's a data fix
   Reason why no related code fix:  
   
*/


update userprofilephonenumber set phonenumber = '(410) 533-7479', updatedby = 'CDM-27645', updatedon = now() where userprofilephonenumberid = 'cd43629e-2a3b-4101-a669-eff09588e82d';


update tb_slpa_snapshot set worker_phone = '(410) 533-7479' , requestor_phone = '(410) 533-7479', update_ts = now(), update_user_id = 'CDM-27645' where authorization_id = 1898408;
