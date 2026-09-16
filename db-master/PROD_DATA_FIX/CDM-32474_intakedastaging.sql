UPDATE intakesnapshot 
SET 
    updatedby = 'CDM-32474', 
    updatedon = now(), 
    jsondata = replace(jsondata ::text , '"supDisposition": "Scrnin"', '"supDisposition": "Progress ROA"')::jsonb
WHERE intakenumber = 'I231010674398' AND activeflag=1;

UPDATE intakedastaging 
SET 
    updatedby = 'CDM-32474', 
    updatedon = now(), 
    jsondata = replace(jsondata ::text , '"supDisposition": "Scrnin"', '"supDisposition": "Progress ROA"')::jsonb
WHERE intakenumber = 'I231010674398' AND activeflag=1;

select * from createservicecase('fc0e262d-d181-4748-bbd9-56c0fb1f40d1', null,1,'fc251376-8745-4381-a750-6a617c748678','intake');

update servicecase
set startdate = '2023-06-23 10:58:00', insertedon ='2023-06-23 10:58:00'
where servicecaseid = ( select servicecaseid
                            from intakeservicerequest
                        where intakeserviceid  ='fc0e262d-d181-4748-bbd9-56c0fb1f40d1'
                     );
                     
update servicecasedisposition                     
set statusdate = '2023-06-23 10:58:00'
where servicecaseid = ( select servicecaseid
                            from intakeservicerequest
                        where intakeserviceid  ='fc0e262d-d181-4748-bbd9-56c0fb1f40d1'
                     );