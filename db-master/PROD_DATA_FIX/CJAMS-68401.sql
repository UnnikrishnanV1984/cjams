
/*
   Issue Description: CJAMS-68401 This case needs to be screened out
   Category/ Module  : Screening intake
   Root cause: Data fix to Screen out the intake I261014101853 and delete the CPS AR case-261023824790
   Fix type: Data fix is done to Screen out the intake I261014101853 and delete the CPS AR case-261023824790 as requested
   Is code fix required : N
   Reason why no related code fix: Data fix
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
UPDATE intakesnapshot 
SET jsondata = jsonb_set(
    jsonb_set(
        jsonb_set(
            jsonb_set(
                jsonb_set(
                    jsondata, 
                    '{DAType,DATypeDetail,0,supDisposition}', 
                    '"ScreenOUT"'
                ),
                '{intakeDATypeDetails,0,supDisposition}', 
                '"ScreenOUT"'
            ),
            '{sdm,screeningRecommend}', 
            '"ScreenOUT"'
        ),
        '{disposition,0,supDisposition}', 
        '"ScreenOUT"'
    ),
    '{reviewstatus,status}', 
    '"Closed"'
),updatedby = 'CJAMS-68401', updatedon = now()
WHERE intakenumber = 'I261014101853' AND activeflag = 1;


-- Update staging status to Closed
UPDATE intakedastaging  
SET status = 'Closed',updatedby = 'CJAMS-68401', updatedon = now()
WHERE intakenumber = 'I261014101853' AND activeflag = 1;

-- Update intake DA status code
UPDATE intakedastatus 
SET status = 8,updatedby = 'CJAMS-68401', updatedon = now()
WHERE intakenumber = 'I261014101853' AND activeflag = 1;

-- Update routing status code
UPDATE routing 
SET routingstatustypeid = 8, activeflag =0,supervisordecision ='screenout'
WHERE objectid = 'I261014101853' AND activeflag = 1;

UPDATE routing 
SET activeflag =0
WHERE objectid= '7713622f-9960-4070-8381-a68737a929d9' AND activeflag = 1;

-- 1. intakeservicerequest
UPDATE intakeservicerequest 
SET activeflag = 0, actiontype = NULL,updatedby = 'CJAMS-68401', updatedon = now()
WHERE intakeserviceid = '7713622f-9960-4070-8381-a68737a929d9' AND activeflag = 1;

-- 2. intakeservicerequestsdm
UPDATE intakeservicerequestsdm 
SET activeflag = 0,updatedby = 'CJAMS-68401', updatedon = now()
WHERE intakeserviceid = '7713622f-9960-4070-8381-a68737a929d9' AND activeflag = 1;

-- 3. intakeservicerequestdispositioncode
UPDATE intakeservicerequestdispositioncode 
SET activeflag = 0,updatedby = 'CJAMS-68401', updatedon = now()
WHERE intakeserviceid = '7713622f-9960-4070-8381-a68737a929d9' AND activeflag = 1;

-- 4. caseassignment
UPDATE caseassignment 
SET activeflag = 0,updatedby = 'CJAMS-68401', updatedon = now()
WHERE objectid = '7713622f-9960-4070-8381-a68737a929d9' AND activeflag = 1;

-- 5. personprogramarea
UPDATE personprogramarea 
SET activeflag = 0,updatedby = 'CJAMS-68401', updatedon = now()
WHERE objectid = '7713622f-9960-4070-8381-a68737a929d9' AND activeflag = 1;

-- 6. actor
UPDATE actor 
SET activeflag = 0,updatedby = 'CJAMS-68401', updatedon = now()
WHERE intakeserviceid = '7713622f-9960-4070-8381-a68737a929d9' AND activeflag = 1;

-- 7. intakeservicerequestactor
UPDATE intakeservicerequestactor 
SET activeflag = 0,updatedby = 'CJAMS-68401', updatedon = now()
WHERE intakeserviceid = '7713622f-9960-4070-8381-a68737a929d9' AND activeflag = 1;

-- 8. personrole
UPDATE personrole 
SET activeflag = 0,updatedby = 'CJAMS-68401', updatedon = now()
WHERE intakeserviceid = '7713622f-9960-4070-8381-a68737a929d9' AND activeflag = 1;

-- 9. actorrelationship
UPDATE actorrelationship 
SET activeflag = 0,updatedby = 'CJAMS-68401', updatedon = now()
WHERE intakeserviceid = '7713622f-9960-4070-8381-a68737a929d9' AND activeflag = 1;

update personroletype
set activeflag = 0,updatedby = 'CJAMS-68401', updatedon = now()
where personroleid in ('509abaf0-de12-4ad4-816c-1009ce438dee', '8dab3a61-1d93-4e46-9b2d-416ca048c52f', '76cf13ad-4a3e-41bb-b96d-da0aa2a1c4a1')  and activeflag =1;