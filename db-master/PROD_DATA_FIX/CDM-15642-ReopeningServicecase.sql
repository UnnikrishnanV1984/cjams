
/*
   Issue Description: CDM-15642
   Category/ Module  :  Case Reopen
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

-- Closed	Closed	2021-07-30 17:29:10
UPDATE servicecase SET statustypekey ='Open', dispositioncode = 'Open', enddate = null, updatedby = 'CDM-15642',updatedon = now() WHERE servicecaseid = '6ae26148-a56f-428e-907e-2f5fcc43f4d7';
update servicecasedisposition s set activeflag = 0, updatedby = 'CDM-15642',updatedon = now() where servicecasedispositionid = 'f07c0a3a-a8d5-46f9-9c77-1fe8a5af7310';