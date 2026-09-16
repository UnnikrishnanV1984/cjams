 
 /*
   Part 1
   Issue Description: CDM-25127
   Category/ Module  : CPS IR Case
   Root cause: User requested change the case to ROH
   Pull request# for code fix: 6710
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update
  intakeservicerequest
set
  activeflag = 0,
  actiontype = null,
  updatedon = now(),
  updatedby = 'CDM-25127'
where
  intakeserviceid = 'b11b0d4e-36ab-4695-a456-f625aa9f28ed';

update
  personprogramarea
set
  activeflag = '0',
  updatedon = now(),
  updatedby = 'CDM-25127'
where
  personprogramid in (
    'b4ce4b49-b044-4db9-9359-7f6ff9948024',
    'ee43070a-4760-472f-8456-c8ab1b036118'
  )
  and personid = '01624d28-e6d6-4a94-a2b5-77b28eeaf058';

update
  personprogramarea
set
  activeflag = '0',
  updatedon = now(),
  updatedby = 'CDM-25127'
where
  personprogramid in (
    '355fa3ec-08eb-489a-a57a-a70ca1021cdb',
    '2a70158f-80b7-4136-a0c8-3407e3cf8295'
  )
  and personid = '1ca95d2e-8216-4c2e-b3f6-27d2a54f00aa';

update
  personprogramarea
set
  activeflag = '0',
  updatedon = now(),
  updatedby = 'CDM-25127'
where
  personprogramid in (
    '8c2fe6ff-e388-4cd2-99d6-1736febdb7cb',
    '560fe647-e2ae-494e-9abc-87c56939a196'
  )
  and personid = 'd32a1353-5563-4d92-839c-af396bf4e1e8';

update intakedastaging 
set jsondata = replace(jsondata::text, '"isir": true', '"isir": false')::json,
updatedby = 'CDM-25127', updatedon= now()
where intakenumber = 'I221010303738' and activeflag = 1;

select * from cjams.createservicecase('b11b0d4e-36ab-4695-a456-f625aa9f28ed', null, 1, '40d63914-2a9e-4abe-9616-c49bf0c269d3', 'intake');