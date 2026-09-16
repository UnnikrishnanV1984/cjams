/*
  Issue Description: CDM-33361
  Root cause: User request 
  Fix Prrovided: Did data fix to create the servicecase 
*/


UPDATE intakesnapshot 
SET 
    updatedby = 'CDM-33361', 
    updatedon = now(), 
    jsondata = replace(jsondata ::text , '"supDisposition": "Scrnin"', '"supDisposition": "Progress ROA"')::jsonb
WHERE intakenumber = 'I231010602272' AND activeflag=1;

UPDATE intakedastaging 
SET 
    updatedby = 'CDM-33361', 
    updatedon = now(), 
    jsondata = replace(jsondata ::text , '"supDisposition": "Scrnin"', '"supDisposition": "Progress ROA"')::jsonb
WHERE intakenumber = 'I231010602272' AND activeflag=1;



select * from createservicecase('01bf1d01-f956-4014-810a-f588edcccb5e', null,1,'9c424094-8dc4-4015-9a32-3a7020615f11','intake');




update servicecase
set startdate = '2023-05-12 12:15:00', insertedon ='2023-06-23 10:58:00'
where servicecaseid = ( select servicecaseid
                            from intakeservicerequest
                        where intakeserviceid  ='01bf1d01-f956-4014-810a-f588edcccb5e'
                     );
                     
update servicecasedisposition                     
set statusdate = '2023-05-12 12:55:00'
where servicecaseid = ( select servicecaseid
                            from intakeservicerequest
                        where intakeserviceid  ='01bf1d01-f956-4014-810a-f588edcccb5e'
                     );
