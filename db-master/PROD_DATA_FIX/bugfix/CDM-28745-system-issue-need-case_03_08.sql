/*
   Issue Description: CDM-28745
   Category/ Module  : revert intake supervisor decision 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   new case number : 231030066769
*/

update ServiceRequestTypeConfigDispositionCode set description = 'Screen In', dispositioncode = 'Scrnin' where 
ServiceRequestTypeConfigIdDispostionId in 
(select ServiceRequestTypeConfigIdDispostionId from IntakeServiceRequestDispositionCode where IntakeServiceId = 'dda82ea2-efa6-436f-b5ff-3ebc267e901c');


UPDATE intakesnapshot 
 set updatedby = 'CDM-28745', updatedon = now(),
 jsondata = jsonb_set(jsondata, '{DAType}', 
            jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"Scrnin"'))))
WHERE intakenumber = 'I231010424471' AND activeflag=1;