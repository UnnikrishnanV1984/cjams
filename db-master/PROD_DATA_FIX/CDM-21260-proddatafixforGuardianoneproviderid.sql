
/*
   Issue Description: CDM-21260
   Category/ Module  : Updating Gap Provider ID
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

-- 5000553
 update guardianship set guardianoneproviderid = '5053111',guardianoneid = '530356',updatedon = now(), updatedby = 'CDM-21260' where gapid = 'a32e37fd-357f-4ee9-a60f-8970cc0bfae9';
 