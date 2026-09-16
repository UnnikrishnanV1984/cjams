/*
   Issue Description: CJAMS-60972
   Category/ Module  :  Remove Unknown person from AR case as requested by user
   Root cause: User Error
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

--actor id
/*
 * select * from person where cjamspid = '204182243';--bf89d765-aaab-4314-9289-6fabbf3ab355
 * select * from actor where personid = 'bf89d765-aaab-4314-9289-6fabbf3ab355'
34addfff-2291-4b8b-9044-9561df067434
009de277-74a3-48fe-8867-61d7961771da
*/

--Deactivating person in actor
update actor
set activeflag = 0, updatedby = 'CJAMS-60972', updatedon = now()
where actorid in (
'34addfff-2291-4b8b-9044-9561df067434',
'009de277-74a3-48fe-8867-61d7961771da')
and activeflag = 1;

--Deactivating peron in intakeservicerequestactor
/*select * from intakeservicerequestactor i where actorid in(
'34addfff-2291-4b8b-9044-9561df067434',
'009de277-74a3-48fe-8867-61d7961771da')
and activeflag = 1;*/

update intakeservicerequestactor 
set activeflag = 0, updatedby = 'CJAMS-60972', updatedon = now()
where activeflag = 1 and intakeservicerequestactorid in (
'90ad4184-f251-49f9-b3c4-b3341fed8de7',
'303abb2e-472b-4a0a-8aaf-10e2f46c3e88',
'ca3e189f-f26f-49de-820d-124683af1274');

--Deactivating person in actorrelationship
/*
select * from actorrelationship where intakeservicerequestactorid in (
'90ad4184-f251-49f9-b3c4-b3341fed8de7',
'303abb2e-472b-4a0a-8aaf-10e2f46c3e88',
'ca3e189f-f26f-49de-820d-124683af1274');
*/

update actorrelationship
set activeflag = 0, updatedby = 'CJAMS-60972', updatedon = now()
where activeflag = 1 and actorrelationshipid in (
'54ec35b1-7a89-4e86-a20d-2f35168e31e8',
'53795c17-4760-4d9f-9767-8caecf1ab957',
'9d3e3d1a-3171-48e2-9741-769e79fc95f0',
'3b1df0c2-88cf-40dd-94ee-9d393a9657e3',
'1ad25950-063e-4b78-8704-10f453e30d64');

--Deactivating person in personrole
--select * from personrole where personid = 'bf89d765-aaab-4314-9289-6fabbf3ab355'

update personrole 
set activeflag = 0, updatedby = 'CJAMS-60972', updatedon = now()
where personroleid in ('077f36f7-17a7-4f23-95bc-22c8d9991081',
'4879b9ef-1f36-48c9-8ce5-00651ef025a5') 
and activeflag = 1;

--Deactivating person in personprogramarea
--select * from personprogramarea where personid = 'bf89d765-aaab-4314-9289-6fabbf3ab355'

update personprogramarea
set activeflag = 0, updatedby = 'CJAMS-60972', updatedon = now()
where personprogramid = '7dae06d1-35d8-4538-8986-b895d533a15a' and activeflag = 1;

update personroletype
set activeflag = 0, updatedby = 'CJAMS-60972', updatedon = now()
where personroleid in ('077f36f7-17a7-4f23-95bc-22c8d9991081',
'4879b9ef-1f36-48c9-8ce5-00651ef025a5')
and activeflag = 1;