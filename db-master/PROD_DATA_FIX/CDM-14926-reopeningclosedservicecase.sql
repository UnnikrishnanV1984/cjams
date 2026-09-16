/*
   Issue Description: CDM-14926
   Category/ Module  :  case closure
   Root cause: user requeseted to remove it user error
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update servicecasedisposition set activeflag = 0, updatedby = 'CDM-14926',updatedon = now()  where servicecasedispositionid = '974bf14a-0bcb-4cc8-b173-d3a003535f4a';

UPDATE servicecase SET statustypekey ='Open', dispositioncode = 'Open', enddate = null, updatedby = 'CDM-14926',updatedon = now() WHERE servicecaseid = 'b6049d66-c043-4776-8742-ffae01d2c810';
