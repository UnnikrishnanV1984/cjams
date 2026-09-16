/*
  Issue Description:  CJAMS-65476
   Category/ Module  :  Referral overrode to add info and screen out but glitched
   Root cause: As per system design, The worker must screen out the intake to remove/disconnect the CPS AR/IR case once it is overridden. Then the respective purpose intake can be change to others
               requested for a data fix 
  Fix provided: Data fix is done to  Change the intake # I261013894010 Purpose from RFS to CPS and Screen out the intake # I261013894010 and remove the CPS IR # 261023630620
   Pull request# for code fix: NA
   Reason why no related code fix: NA
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: NA
*/




UPDATE intakedastaging 
SET
    jsondata = jsonb_set(
        jsonb_set(
            jsondata,
            '{General,PurposeName}',
            '"<p>Child Protective Services</p>"'::jsonb
        ),
        '{General,Purpose}',
        '"247a8b26-cdee-4ce8-b36e-b37e49fd0103~CW"'::jsonb
    ),
    updatedon = now(),
     updatedby = 'CJAMS-65476'
WHERE
    intakenumber = 'I261013894010'
    AND activeflag = 1;
    
   
 UPDATE intakesnapshot
SET
updatedby = 'CJAMS-65476', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I261013894010' AND activeflag=1;

UPDATE intakedastaging
SET status = 'Closed',
updatedby = 'CJAMS-65476', updatedon = now()
WHERE intakenumber = 'I261013894010' AND activeflag=1;


Update routing set 
routingstatustypeid = 8, updatedby = '01e714f6-a2ca-4386-844d-dc4ecedf9c15', supervisordecision = 'screenout', updatedon= now()
WHERE objectid = 'I261013894010' and routingid='e846a321-6a29-48de-813d-60a3904e8c4a';

update intakeDAStatus set status = 8, updatedby = 'CJAMS-65476', updatedon = now() 
where intakenumber = 'I261013894010' and activeflag =1;

update intakeservicerequest 
set activeflag=0,
updatedby = 'CJAMS-65476', updatedon = now()
where servicerequestnumber='261023630620' and activeflag=1;

update intakeservicerequest 
set activeflag=0,
updatedby = 'CJAMS-65476', updatedon = now()
where intakeserviceid='99d4ee05-bcba-47c2-9b01-1688cdd099fe' and activeflag=1;

update intakeservicerequestdispositioncode 
set activeflag=0,
updatedby = 'CJAMS-65476', updatedon = now()
where intakeserviceid='99d4ee05-bcba-47c2-9b01-1688cdd099fe' and activeflag=1;

update caseassignment 
set activeflag=0,
updatedby = 'CJAMS-65476', updatedon = now()
where caseassignmentid='52eed364-2bb4-4bd2-948b-f302343fe018' and activeflag=1;

update personprogramarea 
set activeflag=0,
updatedby = 'CJAMS-65476', updatedon = now()
where objectid='99d4ee05-bcba-47c2-9b01-1688cdd099fe' and activeflag=1;

update actor 
set activeflag=0,
updatedby = 'CJAMS-65476', updatedon = now()
where intakeserviceid='99d4ee05-bcba-47c2-9b01-1688cdd099fe' and activeflag=1;

update intakeservicerequestactor 
set activeflag=0,
updatedby = 'CJAMS-65476', updatedon = now()
where intakeserviceid='99d4ee05-bcba-47c2-9b01-1688cdd099fe' and activeflag=1;

update personrole 
set activeflag=0,
updatedby = 'CJAMS-65476', updatedon = now()
where intakeserviceid='99d4ee05-bcba-47c2-9b01-1688cdd099fe' and activeflag=1;

update actorrelationship 
set activeflag=0,
updatedby = 'CJAMS-65476', updatedon = now()
where intakeserviceid='99d4ee05-bcba-47c2-9b01-1688cdd099fe' and activeflag=1;