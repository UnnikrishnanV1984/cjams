/*
   Issue Description: CDM-28284
   Category/ Module  :Change receive date
   Root cause: ::The CPS referral was not back dated correctly at intake. The referral was received at 4:00pm on 1/24/23 and the intake worker entered today's date, therefore the cps worker's initial F2F contact will not show correctly. 
   Reason why no related code fix:  Data fix

   
*/



update intakedastaging 
set daterecieved = '2023-01-24 16:00:00', 
    updatedby = 'CDM-28284',
    updatedon = now(),
    jsondata = replace(jsondata::text, '"RecivedDate": "1/25/2023, 10:30:00 AM"', '"RecivedDate": "1/24/2023, 04:00:00 PM"') ::json
where intakenumber = 'I231010382748' and activeflag = 1;

update intakedastaging 
set updatedby = 'CDM-28284',
    updatedon = now(),
    jsondata = replace(jsondata::text, '"incidentdate": "2023-01-25T05:00:00.000Z"', '"incidentdate": "2023-01-24T05:00:00.000Z"')::json
where intakenumber = 'I231010382748' and activeflag = 1;

update progressnote 
set intakeserviceid = '183b5058-ac6f-481f-91e4-6ff23c379db0', 
    entitytypeid = '183b5058-ac6f-481f-91e4-6ff23c379db0',
    updatedby = 'CDM-28284',
    updatedon = now(),
    contactdate = '2023-01-24 00:00:00'
where progressnoteid in ('83fff981-da5e-4551-ba6c-2d966b1023d9', 'b14ef0f7-ab00-491e-9c93-1b6971fe3024');

update assessment 
set objectid = '183b5058-ac6f-481f-91e4-6ff23c379db0', 
    updatedby = 'CDM-28284',
    updatedon = now()
where assessmentid in ('95a12460-be69-474f-af6b-38411e67ea2b');

update intakesnapshot 
set updatedby = 'CDM-28284',
    updatedon = now(),
    jsondata = replace(jsondata::text, '"RecivedDate": "1/25/2023, 10:30:00 AM"', '"RecivedDate": "1/24/2023, 04:00:00 PM"') ::json
where intakenumber = 'I231010382748' and activeflag = 1;

update intakesnapshot 
set updatedby = 'CDM-28284',
    updatedon = now(),
    jsondata = replace(jsondata::text, '"incidentdate": "2023-01-25T05:00:00.000Z"', '"incidentdate": "2023-01-24T05:00:00.000Z"')::json
where intakenumber = 'I231010382748' and activeflag = 1;








