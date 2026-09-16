
/*
   Issue Description: CDM-18196
   Category/ Module  : Updating Person program area start date
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

-- 2021-10-19 00:00:00
update personprogramarea set startdate = '2021-10-15 00:00:00', updatedby = 'CDM-18196',updatedon= now() where personprogramid = '50cd6e38-e18f-46c1-bce5-6ce32201196e';