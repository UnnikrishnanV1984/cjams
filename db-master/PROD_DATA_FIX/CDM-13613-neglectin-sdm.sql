/*
   Issue Description: CDM-13613
   Category/ Module  : intakesdm 
   Root cause: user requested change from AR to neglect
   Pull request# for code fix: 
   Reason why no related code fix: 6584
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
update intakeservicerequestsdm 
 SET ismenng_psycologicalability = true ,
 updatedby = 'CDM-13613',
 updatedon = now()
 where  intakeserviceid = '315065db-efcc-4f68-9ff9-e69c81c1b244';

UPDATE cjams.intakesnapshot
SET jsondata = jsonb_set(jsondata, '{sdm,ismenng_psycologicalability}','true'),
updatedby = 'CDM-13613',updatedon = now()
where intakenumber = 'I202100544511'  AND activeflag=1;