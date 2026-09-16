
/*
   Issue Description: CDM-22028
   Category/ Module  : Prod data fix To end date person program
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update personprogramarea set enddate = '2022-03-24 00:00:00', updatedon = now(), updatedby = 'CDM-22028' where personprogramid = '533aadbd-6332-4bf4-a3ad-f4f9b9ebfdf0';