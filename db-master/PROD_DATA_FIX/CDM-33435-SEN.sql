/*
  Issue Description: CDM-33435
  Root cause: User request 
  Fix Prrovided: Did data fix to unchek Substance exposed newborn
*/

UPDATE intakedastaging 
SET jsondata = replace(jsondata::text, '"isnegrh_exposednewborn": true', '"isnegrh_exposednewborn": false')::json
    , updatedby = 'CDM-33435'
    , updatedon = now()
WHERE intakenumber = 'I231010902838' AND activeflag = 1;

UPDATE intakesnapshot 
SET jsondata = replace(jsondata::text, '"isnegrh_exposednewborn": true', '"isnegrh_exposednewborn": false')::json
    , updatedby = 'CDM-33435'
    , updatedon = now()
WHERE intakenumber = 'I231010902838' AND activeflag = 1;

update cjams.intakeservicerequestsdm set activeflag =0, updatedby ='CDM-33435', updatedon = now()
where intakeservicerequestsdmid in ('56164831-9a91-4de4-9533-56417d906412');