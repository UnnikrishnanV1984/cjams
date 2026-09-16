/*
   Issue Description: CDM-32191
   Category/ Module  : Prod data fix for updating document user details
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

--ab7e0e4d-9082-454c-88de-df66a416fcab
--3b634eec-3d6d-49a9-a14a-9ab067e3b8f5
--3871962c-1b28-4562-846c-17cfa5dbcfb2
 update documentproperties set insertedby = '4a38975f-ad9c-4da6-b631-3943a9a8997d', updatedby = 'CDM-32191' 
 where documentpropertiesid in ('15368b0c-3796-4895-b52b-1918ca792f3f',
'7a681623-363a-45ce-8ce3-747060e4140d',
'9ab6f4a2-970d-4bfc-b3b6-f815064c39e3');



--ab7e0e4d-9082-454c-88de-df66a416fcab
--3b634eec-3d6d-49a9-a14a-9ab067e3b8f5
--3871962c-1b28-4562-846c-17cfa5dbcfb2
 update documentattachment  set insertedby = '4a38975f-ad9c-4da6-b631-3943a9a8997d', updatedby = 'CDM-32191' 
 where documentpropertiesid in ('15368b0c-3796-4895-b52b-1918ca792f3f',
'7a681623-363a-45ce-8ce3-747060e4140d',
'9ab6f4a2-970d-4bfc-b3b6-f815064c39e3');