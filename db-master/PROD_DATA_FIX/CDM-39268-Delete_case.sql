/*
   Issue Description: CDM-39268
   Category/ Module  : SDM 
   Root cause: safec checklist is not checked in ar summary
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update servicecase 
set activeflag =0, updatedby ='CDM-39268', updatedon =now() 
where servicecasenumber = '231030238702';

update caseassignment 
set activeflag = 0 ,updatedby = 'CDM-39268', updatedon =now() 
where objectid ='3b984cc0-314c-46f0-9729-96f4122e598b';

update servicecasedisposition 
set activeflag = 0, updatedby = 'CDM-39268', updatedon =now() 
where servicecaseid ='3b984cc0-314c-46f0-9729-96f4122e598b';

update routing
set activeflag = 0, updatedby= 'CDM-39268',updatedon=now()
where objectid = '3b984cc0-314c-46f0-9729-96f4122e598b' and activeflag = 1;





