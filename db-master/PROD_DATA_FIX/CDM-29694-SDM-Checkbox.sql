/*
   Issue Description: CDM-29694
   Category/ Module  : intake sdm
   Root cause: user already added this kid SDM in other case and removed
   Pull request# for code fix: 8448
   Reason why no related code fix: data fix
   
*/


UPDATE intakesnapshot 
set jsondata = replace(jsondata::text, '"isnegrh_exposednewborn": false', '"isnegrh_exposednewborn": true')::json,
 updatedby = 'CDM-29694',
updatedon =now() 
WHERE intakenumber = 'I231010547436' AND activeflag = 1;


UPDATE intakedastaging 
SET jsondata = replace(jsondata::text, '"isnegrh_exposednewborn": false', '"isnegrh_exposednewborn": true')::json, 
updatedby = 'CDM-29694', 
updatedon = now()
WHERE intakenumber = 'I231010547436' AND activeflag = 1;

UPDATE cjams.person
SET substanceexposednewbornflag = 1, 
substanceexposednewbornsourceid='I231010547436', substanceexposednewbornsourcetypekey='2954', 
substanceexposednewborntimetamp='2023-03-25 14:33:39.601', updatedby = 'CDM-29694',
updatedon = now()
WHERE cjamspid = 201185990;