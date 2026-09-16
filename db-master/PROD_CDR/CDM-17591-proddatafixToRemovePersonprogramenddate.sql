
/*
   Issue Description: CDM-17591
   Category/ Module  :Removing person program end date
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update personprogramarea set enddate =  null, updatedby = 'CDM-17591', updatedon = now() where personprogramid in ('9eebd6b3-5812-4f76-a1be-9cdd9b17ba66','660c17d7-23f6-4eeb-9927-2bce1e515fb4','54eb8a8d-2772-420a-8cc4-5a32906e9074');
 