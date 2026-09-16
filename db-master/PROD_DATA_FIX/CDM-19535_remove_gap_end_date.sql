/*
   Issue Description: CDM-19535
   Category/ Module  : Person - Program area  
   Root cause: User wants to remove the GAP end date
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update personprogramarea set enddate = null , updatedby = 'CDM-19535', updatedon  = now() where personprogramid = '48092f1e-231f-4329-bff7-f13d031bc47f' and activeflag = 1;