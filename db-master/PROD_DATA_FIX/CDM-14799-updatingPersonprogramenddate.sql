/*
   Issue Description: CDM-14799
   Category/ Module  :  Updating the End date for Person program
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update personprogramarea set enddate = '2010-06-24 00:00:00', updatedby = 'CDM-14799', updatedon = now() where personprogramid = '0cb6637e-d606-4f68-919d-9e1fb11b90eb';
