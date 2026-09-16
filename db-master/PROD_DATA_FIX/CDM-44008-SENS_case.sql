/*
   Issue Description: CDM-44008
   Category/ Module  :  sdm corrections
   Root cause: user requeseted to update it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update person
set substanceexposednewbornsourceid = 'I251013213791', updatedby = 'CDM-44008', updatedon = now()
where personid = '599de590-acc4-41f5-af58-7023a5374e9d' and activeflag = 1;

UPDATE intakedastaging 
SET jsondata = replace(jsondata::text, '"isnegrh_basicneedsunmet": true', '"isnegrh_basicneedsunmet": false')::json
    , updatedby = 'CDM-44008'
    , updatedon = now()
WHERE intakenumber = 'I251013213791' AND activeflag = 1;

UPDATE intakesnapshot 
SET jsondata = replace(jsondata::text, '"isnegrh_basicneedsunmet": true', '"isnegrh_basicneedsunmet": false')::json
    , updatedby = 'CDM-44008'
    , updatedon = now()
WHERE intakenumber = 'I251013213791' AND activeflag = 1;

update intakeservicerequestsdm set isnegrh_basicneedsunmet = 'false',drugexposednewbornflag =1
    , updatedby = 'CDM-44008'
    , updatedon = now()
where intakeservicerequestsdmid  ='d78bf386-0c14-4f8b-9bd7-c34e3a5f0cd1';
