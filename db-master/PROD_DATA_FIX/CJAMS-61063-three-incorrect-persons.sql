/* 
    Issue Description: CJAMS-61063
   Category/ Module  : Person
   Root cause: User Error, :Upon initial referral creation three people were created in the case incorrectly. 
   The correct persons have now been identified and have been corrected/incorporated in the case.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    void the rejected provider placement from backend
*/
/*
select * from person where cjamspid in ('204189936','204189935',204189934);
e1e5ed00-f13e-4a4b-b9ec-0f0294336105
a9d99bb1-3d0c-4e98-babb-f89c65e39f90
4c42e517-115e-4ba6-9b79-52a226ea2121

select personroletypeid ,* from actor 
where personid in ('e1e5ed00-f13e-4a4b-b9ec-0f0294336105','a9d99bb1-3d0c-4e98-babb-f89c65e39f90','4c42e517-115e-4ba6-9b79-52a226ea2121')
and intakeserviceid ='36eec356-1408-445e-bc32-a1c091ed1320';

*/

--Deactivating person in actor
update actor
set activeflag = 0, updatedby = 'CJAMS-61063', updatedon = now()
where actorid in (
'11c8d82e-82a3-4e56-bafb-60b7daadb4a7',
'77121369-be81-4cb4-8f55-c52deb4e1c48',
'0f40afbb-6d0d-4d39-8032-93c5a7815155')
and intakeserviceid ='36eec356-1408-445e-bc32-a1c091ed1320'
and activeflag = 1;

--Deactivating peron in intakeservicerequestactor
/*
select * from intakeservicerequestactor i where actorid in (
'11c8d82e-82a3-4e56-bafb-60b7daadb4a7',
'77121369-be81-4cb4-8f55-c52deb4e1c48',
'0f40afbb-6d0d-4d39-8032-93c5a7815155')
and intakeserviceid ='36eec356-1408-445e-bc32-a1c091ed1320'
and activeflag = 1;
*/

update intakeservicerequestactor 
set activeflag = 0, updatedby = 'CJAMS-61063', updatedon = now()
where actorid in (
'11c8d82e-82a3-4e56-bafb-60b7daadb4a7',
'77121369-be81-4cb4-8f55-c52deb4e1c48',
'0f40afbb-6d0d-4d39-8032-93c5a7815155')
and intakeserviceid ='36eec356-1408-445e-bc32-a1c091ed1320'
and activeflag = 1;

--Deactivating person in actorrelationship
/*
select * from actorrelationship where intakeservicerequestactorid in (
'09239c90-ffd0-4b70-a257-c79f7342dd07',
'cb8bc7da-988b-40b0-84e9-3d98aabc28d6',
'fcd9e8c2-1c93-42ee-b5e0-b684e4394463',
'1f86b441-05aa-45ea-9eea-00d8c1d5bd1b',
'84ce3364-a3f6-48a9-bbb6-ed4fcea96cf6',
'bae7c6ef-3523-4b44-b9b1-caed45ca23f1',
'e53795dc-e0b2-4f75-94cc-2dadbd918f4b')
and intakeserviceid = '36eec356-1408-445e-bc32-a1c091ed1320' and activeflag =1;
*/

update actorrelationship
set activeflag = 0, updatedby = 'CJAMS-61063', updatedon = now()
where intakeservicerequestactorid in (
'09239c90-ffd0-4b70-a257-c79f7342dd07',
'cb8bc7da-988b-40b0-84e9-3d98aabc28d6',
'fcd9e8c2-1c93-42ee-b5e0-b684e4394463',
'1f86b441-05aa-45ea-9eea-00d8c1d5bd1b',
'84ce3364-a3f6-48a9-bbb6-ed4fcea96cf6',
'bae7c6ef-3523-4b44-b9b1-caed45ca23f1',
'e53795dc-e0b2-4f75-94cc-2dadbd918f4b')
and intakeserviceid = '36eec356-1408-445e-bc32-a1c091ed1320' and activeflag =1;

--Deactivating person in personrole
/*
select personroleid ,* from personrole where personid in ('e1e5ed00-f13e-4a4b-b9ec-0f0294336105','a9d99bb1-3d0c-4e98-babb-f89c65e39f90','4c42e517-115e-4ba6-9b79-52a226ea2121')
and intakeserviceid ='36eec356-1408-445e-bc32-a1c091ed1320';
*/

update personrole 
set activeflag = 0, updatedby = 'CJAMS-61063', updatedon = now()
where personid in ('e1e5ed00-f13e-4a4b-b9ec-0f0294336105','a9d99bb1-3d0c-4e98-babb-f89c65e39f90','4c42e517-115e-4ba6-9b79-52a226ea2121')
and activeflag = 1 and intakeserviceid ='36eec356-1408-445e-bc32-a1c091ed1320';


--Deactivating person in personprogramarea
/*
select * from personprogramarea where personid in ('e1e5ed00-f13e-4a4b-b9ec-0f0294336105','a9d99bb1-3d0c-4e98-babb-f89c65e39f90','4c42e517-115e-4ba6-9b79-52a226ea2121')
and activeflag = 1 and objectid  ='36eec356-1408-445e-bc32-a1c091ed1320';
*/

update personprogramarea
set activeflag = 0, updatedby = 'CJAMS-61063', updatedon = now()
where personid in ('e1e5ed00-f13e-4a4b-b9ec-0f0294336105','a9d99bb1-3d0c-4e98-babb-f89c65e39f90','4c42e517-115e-4ba6-9b79-52a226ea2121')
and activeflag = 1 and objectid  ='36eec356-1408-445e-bc32-a1c091ed1320';

/*
select * from personroletype where personroleid in ('463e600f-cd82-4b3d-b448-1c49d9ad6062',
'38d33926-bfad-4165-a986-025a622f51a7',
'30001e76-c9bc-4ebf-b156-bf5860e9c2e2')
*/

update personroletype
set activeflag = 0, updatedby = 'CJAMS-61063', updatedon = now()
where personroleid in ('463e600f-cd82-4b3d-b448-1c49d9ad6062',
'38d33926-bfad-4165-a986-025a622f51a7',
'30001e76-c9bc-4ebf-b156-bf5860e9c2e2')
and activeflag = 1;