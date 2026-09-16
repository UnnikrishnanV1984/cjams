/*
   Issue Description: CDM-14071
   Category/ Module  :  
   Root cause: user asked to reopen service case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

--Servicecase update
UPDATE intakeservicerequestsdm 
SET isneggn_exposuretounsafe = true, 
    updatedby = 'CDM-14071',
    updatedon = now()
WHERE  intakeserviceid  ='5606b27e-6142-4973-a213-232a3a66d8a4';


--Intake update
UPDATE intakedastaging
SET jsondata = jsonb_set(jsondata, '{sdm}', jsonb_set(jsondata->'sdm', '{isneggn_exposuretounsafe}', 'true')), 
updatedby = 'CDM-14071', updatedon = now()
WHERE intakenumber = 'I211010160028' AND activeflag=1;


UPDATE intakesnapshot
SET jsondata = jsonb_set(jsondata, '{sdm}', jsonb_set(jsondata->'sdm', '{isneggn_exposuretounsafe}', 'true')), 
    updatedby = 'CDM-14071', updatedon = now()
WHERE intakenumber = 'I211010160028' AND activeflag=1;