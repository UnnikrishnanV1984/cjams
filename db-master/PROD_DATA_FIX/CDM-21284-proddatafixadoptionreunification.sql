
/*
   Issue Description: CDM-21284
   Category/ Module  : Unable to end date adoption reunification
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
-- null null
update permanencyplan p set parentname = '00000000-0000-0000-0000-000000000000' , parent2name = '00000000-0000-0000-0000-000000000000', updatedby = 'CDM-21384', updatedon = now() where permanencyplanid = '357d2bb0-b963-4b0d-84a5-d15b2fa0a62e';
