/*
   Issue Description: CDM-14830
   Category/ Module  :  Case connect - updating assesments
   Root cause: user wants to update
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 

   For backup please use this existing service case id to update all the below things:  
   Old Service Case ID : edec6bd3-107b-4ade-b30e-41523f079771
*/


-- Service Agreement
update serviceagreement
set caseid = '755e34fe-c4d2-485d-af8d-fba44148552b', updatedby = 'CDM-14830', updatedon = now()
where agreementid = 'b77e4a30-50f9-4229-bd70-01376ca5ae76';

-- Contacts
update progressnote
set servicecaseid = '755e34fe-c4d2-485d-af8d-fba44148552b', entitytypeid = '755e34fe-c4d2-485d-af8d-fba44148552b', updatedby = 'CDM-14830', updatedon = now()
where progressnoteid in ('cbeddec7-6072-4257-a6c9-5664de1b5232',
'50094a6e-7656-4d7b-9c78-aa242bcc4470',
'458beb5a-c502-4dc6-8346-93d9bf40a7eb',
'668bbed7-2b9d-4360-a0a6-7365d8816498',
'85e344b7-80cf-437b-a4a1-fde1d9f6fed6',
'baf38afe-ef7c-4d05-b461-1ac04e30d863',
'f1b08d60-1104-4b6b-948a-ea3bb8e898fb',
'7f7c72e6-3ea7-4189-a027-dad7d4b4354f',
'e38acdee-d1fa-46d9-ac02-00e2869f0c5a',
'4e8080a2-56f1-449c-8c7a-4f4c856a8e0c',
'4152fcd2-5395-45f3-afc9-6e52730e905c',
'3b36f017-776b-4242-a40c-3466e9f566d5');

-- Assessment
update assessment
set servicecaseid = '755e34fe-c4d2-485d-af8d-fba44148552b', updatedby = 'CDM-14830', updatedon = now()
where assessmentid in ('a3f69679-4ada-491a-a426-6e2f8c77c83e',
'9e68fa69-421c-4719-91dd-47966ac05e75',
'7757d340-9ccb-4d2f-9f50-5a17848f7d5d',
'fa0b6f82-fef8-4dd3-91e8-0117161eb760',
'5acabaa0-e9e9-463c-8bdb-42e9a7d599df',
'3cb8fb27-7d1e-40d0-a18a-652b2c80e17f',
'82b6f93c-f649-466b-84e7-8fe72e501478'); 



-- Documents
update documentproperties
set servicecaseid = '755e34fe-c4d2-485d-af8d-fba44148552b', updatedby = 'CDM-14830', updatedon = now()
where documentpropertiesid in ('307789d1-af4c-4c7c-8c36-8006f3ef4c36',
'ed94b849-5232-41f6-8088-7b5e8ab6e0d1',
'829d5b3b-f283-45fa-9079-f5b3105ce67f',
'92622de0-6675-4bef-986c-236d44c05cb0',
'72f49140-c56f-4836-8139-a890167c494e',
'1af091a0-0d07-4e4f-add3-69346ac87cdb',
'26cd322c-8e90-4de0-88a1-c44aa267bcda',
'd551080a-8e61-432f-9696-697f430f7f9c',
'd352a0db-0ab5-48a8-a299-84e5b80a102f',
'9b60839d-90a8-409a-a7ab-9f5d5bf96912',
'85f11bf4-17c8-47b5-a511-15c7930e56a9',
'a15c0994-20b7-44a0-a391-a734eefd032b',
'566e6419-152a-4315-96b6-56a530db85b4',
'437191f7-0c5c-4ac9-93c0-eaf1b525e20a',
'a2047750-6102-49cf-a6bb-3e403ff6ca1c',
'df4fddc1-8c73-48c4-8d4d-c0d7973eaae3',
'df4fddc1-8c73-48c4-8d4d-c0d7973eaae3',
'ae91ec5b-3c0d-492e-8f28-8f69bfdb65f4',
'29e7131f-034b-4aa6-8116-f74103ca1312',
'8c16c1ab-c5e2-40b3-a6e6-f5eb1b894721',
'eda7950e-b9c2-495a-b6be-1f843773df8d');

