/*
   Issue Description: CDM-15038
   Category/ Module  :  child welfare 
   Root cause: user error duplicate contact
   Pull request# for code fix: 
   Reason why no related code fix: 
   user error duplicate contact 
*/
update progressnote 
set 
activeflag = 0,
updatedon = now(),
updatedby = 'CDM-15038'
where 
progressnoteid = '1bc30bfc-cfaf-4e29-8056-6b66fd29441b';