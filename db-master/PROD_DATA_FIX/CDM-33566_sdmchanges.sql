/*
   Issue Description: CDM-33566
   Category/ Module  : intakesdm 
   Root cause: user requested change case type
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update cjams.intakeservicerequestsdm set isnoimmed_physicalabuse = false, isnoimmed_neglectresponse = true, updatedby ='CDM-33566', updatedon = now()
where intakeservicerequestsdmid ='d0d3902d-1e92-4d84-867b-fc2d8a49b7ed';

UPDATE intakedastaging 
SET jsondata = replace(jsondata::text, '"isnoimmed_physicalabuse": true', '"isnoimmed_physicalabuse": false')::json
    , updatedby = 'CDM-33566'
    , updatedon = now()
WHERE intakenumber = 'I231010929551' AND activeflag = 1;

UPDATE intakesnapshot 
SET jsondata = replace(jsondata::text, '"isnoimmed_physicalabuse": true', '"isnoimmed_physicalabuse": false')::json
    , updatedby = 'CDM-33566'
    , updatedon = now()
WHERE intakenumber = 'I231010929551' AND activeflag = 1;

UPDATE intakedastaging 
SET jsondata = replace(jsondata::text, '"isnoimmed_neglectresponse": false', '"isnoimmed_neglectresponse": true')::json
    , updatedby = 'CDM-33566'
    , updatedon = now()
WHERE intakenumber = 'I231010929551' AND activeflag = 1;

UPDATE intakesnapshot 
SET jsondata = replace(jsondata::text, '"isnoimmed_neglectresponse": false', '"isnoimmed_neglectresponse": true')::json
    , updatedby = 'CDM-33566'
    , updatedon = now()
WHERE intakenumber = 'I231010929551' AND activeflag = 1;