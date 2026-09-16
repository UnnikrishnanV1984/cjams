/*
   Issue Description: CDM-14294
   Category/ Module  : documents and contacts transfer
   Root cause: user requeseted to documents and contacts transfer
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


--211030013009, 4a5b06e9-31c3-4f2f-a03e-3a373b7ee6b7
select * from cjams.createservicecase('6f0e29fd-1439-422f-a8fe-d4546d2fb70f', null, 1, '0c4766b7-415f-4047-a51b-47cef2c5e88c', 'intake', '');

update servicecase s set startdate='2020-10-22 17:35:00',updatedby ='CDM-14924',updatedon =now() where servicecaseid ='755e34fe-c4d2-485d-af8d-fba44148552b';

 
update progressnote
set servicecaseid = '4a5b06e9-31c3-4f2f-a03e-3a373b7ee6b7', entitytype ='servicecase',entitytypeid = '4a5b06e9-31c3-4f2f-a03e-3a373b7ee6b7', updatedby = 'CDM-14924', updatedon = now()
where progressnoteid in ('3049930e-af51-47cd-9681-4b5877ca07dd',
'90882aed-315f-4816-becb-3ca5e45745c7',
'db690ab8-c30b-4ad0-a63a-98e85230775b',
'3b48346e-58ad-4bbc-8ea7-59ab82e52940',
'a334b93c-585c-41d3-a28d-bbc9ad1d0e8a',
'81378bc9-b2b3-45a7-8607-0dcc65be57dc',
'43466af0-bdaa-46af-95cb-7d6790785fa0',
'b1bd2f8b-43da-48a4-96f0-81234492e896',
'1a64c70c-804a-4bce-9d2a-66ef9dbbdd32',
'12675195-0011-4709-b54a-2eb79961314b',
'be8f833b-c3f8-425c-9770-8a692ad21317',
'74f3dad0-a9bc-43ed-9827-5d4437beacc3');

update documentproperties
set servicecaseid = '4a5b06e9-31c3-4f2f-a03e-3a373b7ee6b7', updatedby = 'CDM-14924', updatedon = now()
where documentpropertiesid in ('feb37f39-2c0d-4ed4-a109-27ef0d982dcf',
'52af669b-c662-454d-85fe-20165ffdb546',
'9b719eb8-56f2-42cb-a9e1-e52627c80eb6',
'a47ab605-9b2c-4aac-aabd-3f27602e2475');