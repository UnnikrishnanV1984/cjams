/*
    Issue Description:  CJAMS-69543
    Category/ Module:  Intake
    Root cause: SDM Sen flag not enabled even with the active sen child
*/

UPDATE intakesnapshot
SET jsondata = replace(jsondata::text, '"isnegrh_exposednewborn": false', '"isnegrh_exposednewborn": true')::json
    , updatedby = 'CJAMS-69543'
    , updatedon = now()
WHERE intakenumber = 'I261014140633' AND activeflag = 1;


UPDATE intakedastaging
SET jsondata = replace(jsondata::text, '"isnegrh_exposednewborn": false', '"isnegrh_exposednewborn": true')::json , updatedby = 'CJAMS-69543'
    , updatedon = now()
WHERE intakenumber = 'I261014140633' AND activeflag = 1;


UPDATE intakeservicerequestsdm
SET drugexposednewbornflag = 1, updatedby = 'CJAMS-69543', updatedon = now()
WHERE intakeserviceid='c929278f-63ec-4a51-9912-2b3c9728e3a5' AND activeflag = 1;