/*
   Issue Description: CDM-28536
   Category/ Module  :  sdm corrections
   Root cause: user requeseted to update it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/



UPDATE intakesnapshot 
SET updatedby  ='CDM-28536',
updatedon =now() ,
jsondata = replace(jsondata::text, '"isnegrh_exposednewborn": true', '"isnegrh_exposednewborn": false')::json
 WHERE intakenumber = 'I231010401640' AND activeflag = 1;


 UPDATE intakedastaging 
SET updatedby  ='CDM-28536',
updatedon =now() ,
jsondata = replace(jsondata::text, '"isnegrh_exposednewborn": true', '"isnegrh_exposednewborn": false')::json
 WHERE intakenumber = 'I231010401640' AND activeflag = 1;

