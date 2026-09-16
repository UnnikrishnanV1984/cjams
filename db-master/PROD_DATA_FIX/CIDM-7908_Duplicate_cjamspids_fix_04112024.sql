-- CIDM-7908 - Duplicate cjamspids
/*
Issue Details: CJAMS has 368 historical person records that have duplicate CJAMS PID. 

-- Category/ Module: Person
-- Root cause: 
-- Fix Provided: Datafix has been promoted to update the duplicate cjams pid with the new value.
				 Along with that for 8 person records cjams.adoptioncaseactor has been updated with the correct personid.
-- Note: N/A
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '62d1bc4c-c77e-4768-ad5c-d329fe5d25d9';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'afc03be7-933d-4366-be19-119d9e586a13';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '125755cf-9d18-4fab-b19f-cd3fa9f9868b';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '95bc8326-46bb-4657-abba-d5c9f193cef7';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = 'fae9d421-0124-4ae7-ba2c-90983074c3ef';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '81a5bdc6-e4df-41fb-892c-c71ec84ff330';

update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'd57b9ba1-bbc0-4e92-8bb1-42dd532e44f9';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'de862bd5-af75-4002-94fa-7f5959d249fa';

update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '1f87b014-ed55-4e52-9f30-e39ad35de169';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'e8c1c658-c01b-4dbe-929c-9f2f0b374be5';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '3bd2beab-df67-482d-a42f-3bac06776d93';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '78ed5025-9bf4-4ccc-9417-4688b8fc394c';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '1976b83f-0f65-4e11-a409-12ae50224893';

update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = 'c75ec894-de49-4c1b-995a-396f929ad43f';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '9e44afe1-4d57-4641-a506-7844b3e4214b';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = 'c180c41e-8544-49e4-ab54-f1c68d55ea85';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '76b141ca-8773-4538-b547-42c93f2f542c';

update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '792418d9-e5ea-483a-b4eb-9e2880235e78';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '47ec3e58-147d-42fc-8ab9-dff1bf89eff4';

update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'bc5fe3e5-7ef8-4346-953c-c7a9164eddf9';


update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'fd563d3b-1aa5-45f1-85f3-d7df3da992d6';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '8957e43b-748f-4623-bfe6-c6d311e53c73';

update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'deb6282b-4f2f-4f52-abe1-8a09dc9b63f3';


update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '607fd566-6adc-4fba-876b-af185725de60';

update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'c24e944a-1ed7-4915-be70-df7a46ee40e1';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '0ed4585a-75ee-4c94-b506-0b0f4de5506e';


update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '087b8b3a-409b-4754-9da6-cfeb2c63f292';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '8a1e2f3d-ce3a-4b7e-8827-225b996b8b8a';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '5ef75385-9ec5-4234-95b5-fb3c65045009';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '1e7f750f-0fc1-43a1-bf89-631cfc247025';


update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'e4fb3196-6fa6-43e9-a848-02a666bde772';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '992fb60d-d5a3-47bf-85c7-85155e60c11c';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'b8b5a88d-61b5-4459-986a-730fe9553680';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '742da7af-a85d-4184-bf56-c709356adc5f';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'b5a92275-9ed6-4a17-b320-c3099e59bb19';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = 'c739fc69-5447-4372-9304-ea84ccbd9c85';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '32df8db3-ab35-45b9-8fe9-33ed69fc157f';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '02b6f755-18f7-4d25-9879-8ffb9ce899b5';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '7d4ecc6b-5a18-4923-9b08-a7f44e16b2f4';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = 'f3f608e4-b47d-47b2-a937-2c9a53161346';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '2f1324b0-89d0-4284-88c6-3c5ba5a92135';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '0a63dbaa-57ee-4046-b9f1-399a98b0dbdf';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '69511a26-d842-429a-bac2-0d2e1802ce4c';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '7baace6f-a316-4ce7-a4a1-eadea3ee76b1';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '79c00559-0d11-4ffc-bc51-86b984c32fba';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '8482d952-73ea-49e4-ac15-4a097ce6a8fd';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'e329e486-f942-4b55-b84c-f8c43c2ac1ff';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '79dd94a3-a51a-4d03-a066-766da9cf78e5';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'a4881390-8cf5-4c48-9c82-a69b157ceb49';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = 'fcc655a4-f1bb-4ad6-b23b-8172e61ed235';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'b1e08bfd-4aef-4655-92ab-7b73964839f7';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = 'aa4d05c0-c836-4fea-9fe8-2f9fd9eab252';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'd830a9e3-9459-4a84-a127-e6b5d096f424';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '056f88d0-84e0-4d0e-a118-b8b1a8b5d3f5';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '882c1b9f-4e93-497e-a93b-3a4aca9944ef';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = 'c01c3f7f-d53c-4cd0-9228-7e3c9de2a791';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'bed805fc-28f9-446d-a640-bef801d0299a';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '7b708dea-155e-4893-bb82-b24b5539e0b7';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'ef34ad1d-a475-48ba-bd7a-d4032b5e17b9';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = 'aa53b36e-fe7d-4b23-a2c5-3c36eefd8cb2';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'd53016ca-a22f-4ade-adb3-28474198d539';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '0ca89709-9fa8-4088-bf5f-b1c2d1fbbbec';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '497aa8dd-c891-420b-8d3b-4fd2a76f2c94';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '03b884c7-1487-4b9a-ae0b-76c1a0946c7e';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '04c927f3-e327-45d6-8420-0274670d1f54';

update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '08fee718-43bf-4cc3-8e7c-903848bd4be6';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '73629ba8-0574-4e6e-9c45-4261bd4fbe5c';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '0cefe6c1-2be7-4022-8977-2dbbb8f17c0b';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '6e4cfe11-eef0-40d0-b1c6-5a950004f378';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '8530d0e0-3bf8-4d8b-8b22-6e64a944a1b5';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '83468513-1613-412c-ba48-c2ac74483e9e';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'f2269b2b-dab1-4c87-8aa9-224615277777';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '9c835b1e-048b-4fc4-83f6-c45d8fe10956';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'b6cb8234-925f-4780-a07c-cf7ce0257e07';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '06c0c7f5-dfe6-42c1-98b9-88326ea8b562';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '5a31e23e-cd31-4028-b375-c0066a0762af';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '1afcd4f9-6892-4646-9046-79f01cae2b97';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '5c55fe91-1f9b-4bf1-a4da-9d326a259851';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = 'e41de972-77b4-4d5c-afe1-ae97eac3118e';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'aa6fb0b6-280e-47c1-828c-6f8ec4869710';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '617b3094-1ffe-4a24-a372-22ca5244e39f';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '76d9e36a-2a36-4556-833c-6d102c6fd52d';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '063c0030-c018-4b9a-b6fc-97a50d1f4983';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'bf6e9075-4b58-4d71-9141-e47378650082';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '28e11de4-3438-40b6-bcd9-ff73ba196160';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '19b2da23-91fb-4dfe-9a3e-2ac1eadb5e89';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '3679a826-f262-4dc2-bb61-3f0a449602dc';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'c48ccd71-31c9-4911-babb-49f3b5f4cb01';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '289ce1d8-9247-4abb-a258-35c4bcd145f5';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '94cfe737-781c-4d9e-bf92-9e7888423273';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '919a669e-3f4d-48f5-8de7-cf644e05b28b';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'a080c6b2-968f-4a2b-b1cd-aed00a1f4bdc';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '5778089c-e9f2-436b-aa63-25f9bd4563dd';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'f7120b55-5f2c-4d6d-bd4c-1b82a48cd578';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '42b51632-bebb-431e-9efd-f0f50835139e';

update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '613c66a0-6725-46fc-b72c-4e30847945f1';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '8f27504e-cfc4-46e0-89ee-1f72fa18b4ee';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '137b35ec-45b9-4317-946b-b370482e83af';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '03716428-9131-4288-8475-09dadc0a6efc';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'd33cb28b-c01b-4f44-a59e-162aa357a7b6';


update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'c33d37e5-a83f-4e72-a083-f0567ace3f95';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '514f8b1f-c416-44d1-b88f-ffeb3cb1c4fc';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'c0c66d11-17ce-45c3-86b3-b2bb10d72071';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '25e425ed-0cb5-40c5-a09e-2f2844f10719';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'deef9811-71e8-496a-a223-6ed195d3490a';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '3ad9a09e-9041-44e5-a8f6-f19bad89f1cf';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'a3c84544-5217-4581-8268-28db08d9b00e';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '0ae52104-4443-42b7-9d60-78a81922d4c1';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'b0304c78-6fd9-4b1b-b40b-5180f316b7c5';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '584b0c72-0f22-41b0-b3be-818f95751955';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '82ca26bd-990a-4b83-9e7b-ad6f04db2aef';

update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'afd66127-dfeb-4b35-8b20-5d16ee22d8f0';

update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '24929739-dfa8-4afd-aa52-d7d0964b643b';

update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'b8fc9fda-83ce-4593-b7e9-9bf049ac9726';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '101a19a4-8593-4544-a963-72ff171ab46b';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '9f30df80-e8d1-4083-9e1c-4b41751796af';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '2a4433c7-c57e-4fa8-8946-0adf39189877';

update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '9e09c5aa-ca2c-4d8e-8e54-c7525f8d9b7d';

update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'dfd2d0db-4ba9-4ef0-9859-5ecc20cef1bd';


update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'f992fee1-2f55-43b3-9c61-1af90497fcb0';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = 'db59e2a4-c417-4023-939e-0b495c225ac4';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'e9375c6b-b835-4fdc-8e07-9c76920597ca';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '79eb49b9-c0a8-4a90-8785-cef39674ff80';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'ab82de26-6abe-473c-9bfb-b99b993a084e';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '1dbaa612-4a4b-4777-b1fd-d0a797d54c0a';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '8dd543b4-2f37-49f7-85f3-6e8c3cc07a1a';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '8346dfd4-abe5-4661-b9b1-ee57497c1c4b';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '551d44f7-56db-4335-be13-9264ae3b554e';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '8edb4910-0fa6-4b24-b204-d7b2fc222457';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'ba906502-804b-4968-ba04-732a9473ed96';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '98c01a6d-ed5b-4964-9fd1-62133a407a8d';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '20b287a6-2a0d-40c7-9e29-89ea02a6f2cb';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = 'ee4a48ed-ffa5-4b14-a24e-d0e164cf4e43';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'fc741d0e-7fd7-4754-830e-8fd8cd399781';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = 'bebb056d-d017-416c-9b83-cb8a9d7d7d92';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'a44af15f-5246-41f4-b09e-40085b29e8f9';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '086f8eb0-0135-45a8-a3a3-f4aa66b5a07d';


update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'cceda3cc-c497-4600-b1fc-4b45ffdd4209';

update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'b463bc31-b026-4414-9da5-81836845df73';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '17a7c7ee-8db7-49ee-9988-0236143556ca';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '59ba747d-9442-4807-8b28-aa04f1378d32';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '1c33561c-536a-4831-a780-e6ee749b5871';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'fa71466c-eb42-4233-9f69-3071f260eb24';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = 'e4267085-a94d-447a-ac7c-d0c9014bad7c';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '415a2b3d-144a-4c35-93e7-ea275e613a10';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '3097e9a0-f38c-43c9-94c4-cc72fcd63f1b';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '99830fe7-685d-4e2d-9915-4104213feba5';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '1634d460-bf02-4ad8-82c9-4e05756c9773';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '200c1b7a-dce2-4b77-acc9-5dd02623ac6e';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '23ff3318-d332-4cf1-b58a-634193a272a8';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'f5098d91-240a-4572-90d2-da1a2ef5665d';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '3c036054-d0bf-4d1e-b953-ba44a776e2a6';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'f47dd8d3-6440-4890-9ffb-4724fcfc6d99';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '70cf5270-8a7b-496d-98cb-cb53272b9e70';

update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'b8101fef-4639-4feb-9797-e2a4f11a48b0';


update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '484962ee-dcfb-4f0f-8c05-f03664709096';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '7ec9bc13-8167-4c54-86f1-af743c352d27';

update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '24668ed8-caee-4153-ae4d-d4eadcc0c2fd';

update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '4184cfd8-84a9-4d2d-8f29-0d97518971d2';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'f885dee3-f0ed-4f1d-b33c-b0d520536375';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'b213ba73-872d-47ee-80bf-6f7ee76a4c96';

update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '0a3be324-54a0-4263-b1a4-3c31642129d0';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'ea52a29b-a0ae-472e-8b2b-ee9cd58db3a6';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = 'c7a2ea24-f992-4a20-b42e-495358178f6d';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '08efe8dc-a573-474e-9e99-115d58dc90fb';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '52e8b841-9474-4374-b354-b9f4b4beb19c';

update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'f6fa9264-5892-4182-b82f-c5392b175b1e';


update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'f6ff5713-2863-4144-a75d-5a3a1636d246';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '59be6a92-1f36-44d0-80a8-63ae51010194';


update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'a53df08d-3d3e-4809-935d-21bc6f1e4105';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'ffe8e2ae-b745-46ee-904f-56222354050f';

update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '9c75c79d-1ecf-4da1-9291-845946142ffb';

update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'cdaab039-d41d-46dc-b7b8-b5c89d2e5844';


update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '8915a64e-f8e7-4668-9ad8-0857f19c25de';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '0dd1a587-4324-4d5d-9e32-e267db34b085';

update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '82c930b8-c544-4c5e-a711-6115e47f4f08';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'e3471f15-9ff6-4813-9771-eef88747eb13';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '0c5b85a5-74d3-4ee2-8d37-e8c8295156c7';

update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '13c8fee0-531f-4fa6-bc6b-e06057df4d12';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '868a1e02-8cf4-44c9-b769-0f88cc50ff77';

update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '35065ce3-3ac3-4dc5-9e64-a1d08f05b311';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '2fe59077-b42e-46dd-b958-8a09fba0bdef';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '1d2e379d-f741-45b0-9e8b-6046497a1b05';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'f712ed16-61fd-40f2-81fb-ea6e994b4e8e';


update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '13c184a1-a91c-43c8-a618-e351a6b99c86';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '0a28253c-694b-4ffb-8234-96c96a58d4c4';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'bdcbf7f5-d502-46b8-9ff4-ba7d100f47b6';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = 'a10ff4a5-62cf-482a-b5ca-dbc7a8d79d31';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '9506259e-2cb9-4837-a155-fe64fc5da339';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = 'e5e435c7-5e93-4b4c-beb9-210fb3bb6e12';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '44450d91-f6b8-45f8-8fe5-6414fc0e5c42';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '54f561c4-e5eb-4aec-b97d-0eb0b9feaabf';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'd1586d7f-bf27-4eb1-9945-3a13804eb3f4';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '0c727f23-5940-45f4-a103-685321f8f7d1';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'c2fd86c4-b3d3-409b-b3dc-c34847d03808';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '7511ec7d-ba9e-448c-a61a-c0cb7f6b69dc';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '3161f5a9-80f2-4877-a47a-51bfe02e5ac6';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '7e780490-327b-44c7-a144-22c633f055e1';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'd4450e2c-6e34-445a-8059-57d517ce4b5d';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'ad129db4-4f16-46b6-95e5-94cfdd9bdc83';

update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = 'd5066484-d5a6-4c6f-8221-e5ed9c7adc02';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '4c86b913-cdfd-409a-8921-8ef825d2c7fc';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = 'a7ffe1b3-f391-42bf-ae5c-264d43dc197a';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '56b6db39-d085-4fdf-8f08-1bbf60a5dc60';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = 'f9d50928-49f8-4260-b803-86af49679c9c';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '592210d8-b49a-4c5f-bafd-f5050d7523f1';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'ebfeca10-9fca-4537-a6d9-e2ebadcefbbb';

update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '15a64e73-2d47-46de-91ff-ae37b6edb9f2';

update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '68e1b936-8ddc-4d23-8b5e-7ea2876e7f73';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '42ee0857-51af-4aa1-8709-73b32e5aab4b';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = 'e71bca0f-5b1e-4c00-ab53-35a0e8f9bcaf';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '0d12f63e-24d8-43e9-9d6f-0b7dba067aaf';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = 'dd696099-e06c-486b-a5eb-96a7745d4fb0';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '3f5d99db-8cf7-43c1-865c-ecbde4992e85';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '3a0e8966-a2cb-4202-a59e-168b22eeb183';


update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '92a20311-b3ca-471e-9d50-ca1b8a698d88';

update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '7b57d6f6-128d-4d1b-99cc-f1488c52f6a9';

update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '688a45d1-727e-4983-97de-87819875ffbb';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '500fe356-92f6-49cd-8cb4-d47c48896220';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '34a6c421-d556-46ba-a6ac-2c0cc92e999b';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '8848829d-3566-4884-8d37-fae34e545430';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'cc9fb5d0-d2ef-4094-bec5-ab626c303c2e';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '621d9e69-b1d7-4b7c-a9e2-874406021a88';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '469b9075-ad11-485d-b04b-993a9baffd31';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '4d0d1fa5-f873-4a51-b0d8-2e4d31ae7a5e';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'f635304a-4f92-4e67-81c5-28b50417e888';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '8306381b-9fb9-452a-b672-b8f31683e48a';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '8498163a-b34f-4d0e-832c-285c44fc4b5b';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '685977ec-b753-4301-b417-6154e0a3d7ac';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '1e09b440-17cc-46d2-8877-38ce9c5e90f9';

update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '11178e08-b9f4-4aab-9ab7-71dba31e841f';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'a6d46633-adbc-4563-8a76-146ea2eee834';

update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '47d0ea94-cefc-4bc1-9692-80de4cbdcec1';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'f8e0d76c-12df-427a-a334-2e926e4d35fd';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = 'bf1ebeae-3491-46cc-89c3-e58943a57d0b';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '71b060f9-e6b0-4e4f-b464-ee5ba880daea';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'dafd1cc2-62cb-4083-96be-5a9d83ae5b3d';


update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '502a7197-c555-47e1-b0f6-05b5e6fe265b';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '659c7970-5c92-46e6-ac81-e80861409689';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '6b03f06d-eda1-45ca-9e4c-9450e21c9730';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'cff456db-02ef-44c3-ab8d-9bab769512f4';

update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '2602824c-2df9-4c48-aa2e-399e07415384';

update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = 'aaca3cf0-b8e4-4615-9307-f67df151fc9e';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '20592273-5994-4938-86b3-54ef03702d93';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '079a6da4-8d3a-43f0-bb44-a5bef413bcdd';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '6732fe38-7b38-48d6-8103-6247346013da';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'd8a322e1-0e7f-4863-a1b2-17d80f9c6128';


update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '4e578b0a-9d66-418f-bffc-8794ff69770a';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '21597614-a8bc-48ba-bb95-bfdbecec8ee4';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '94075efe-9492-4598-a8e6-f525902181f6';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = 'b64bddb5-4c04-4405-87e0-ba4d49bb58f7';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '434969a3-af30-4064-94b6-b1cbe368edd9';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '9104572c-1f6c-4962-a584-4ffe3c865109';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'a8995eb8-5ea0-4e93-a591-267610698149';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = 'c5dd6c9c-8634-49b5-ac2b-ad2d5748ac8e';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '43d5b320-70b0-49b7-acff-a7254deb3a2b';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = 'ea7e4b99-531b-41b5-8c90-d3d7a00ffd52';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '6e9e0200-71e2-4315-a8db-159d0db4caad';

update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'f54d735d-8711-4df8-a492-c0e924ac542d';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '17b4f3de-7285-403d-b74d-9028cc24ea15';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'd272128a-020e-438f-8cb6-25d16b9e8353';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'd3148c73-477e-4140-84cc-5b9f1be163b5';

update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '2c66f329-ab05-44a6-9ebd-708515ddf60d';

update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'cd9abb28-1a47-4e4e-827c-25bd8f3b2840';

update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'ac6145a7-940d-416b-b841-6baa68e1fb85';


update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '3c67db4f-6e0f-4ab5-aa3c-7ab9538ba112';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '0b1e3cf8-9de0-40b8-8eee-e4f51d33f64f';

update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '140c627e-cd59-40fa-9426-7d81943812b5';

update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '221abd00-0cac-4416-829d-8b9ab0de80db';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '0a0a1ff0-3909-4666-a508-5ec9be2994f3';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '38489c83-0a1f-43fe-911c-850d5803c97d';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '410f3ba4-55f0-4455-9193-443fe4a881b5';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '2134c9e3-901c-4fbc-9038-ccc0a70ef10b';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'f0bc45ad-1f23-4081-99bb-4675354a7fa4';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '701b9101-cf9c-440a-bebd-dc38bf9d80a0';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '0a0afd71-a565-49aa-afaf-2f8646a0f0b0';

update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '7547f434-f60e-4821-9b60-6d6ec571b0f6';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = 'f87c9108-e3e9-4e0c-971d-63fd5a2b1e3f';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'b945e972-99f2-465a-92e5-337e966dcc3c';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = 'e7e20f3c-6b41-496e-ad62-2131a20121a6';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '243af735-9b37-43a8-ae41-8060796514ee';

update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '37f2e21d-6f90-4267-9ecb-ad631af23c58';

update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '0b096cb4-b4ae-437e-9f41-844713a7f71f';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '3e5423c1-bf98-4785-8235-c245cec142e3';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'e6679f2c-2e9a-4625-abac-414f8b9962eb';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = 'df163719-016b-4d33-8a39-10f157733208';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'a394e25a-c66c-454d-bf0a-a74122727765';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = 'a91f37e8-57d9-4df5-b0d1-012f6a32c24e';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'ffaa0b5a-4af6-4fd6-a8b4-a5c8c3d9d702';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '18e328be-409a-4419-adbd-d036562e3481';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '8ae2ecb8-dbdf-4ba7-99c2-fcdebe3b81c3';

update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '2e0b4fbc-d1ed-4891-b2c6-78ff21319752';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '2647cf09-7185-43aa-bb07-6122693169bf';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '2c4d0fd4-67ad-4a3e-8c05-1184bc5f6a53';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = 'c6e81c46-f0d9-40fc-ac36-317ff2880809';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '76864d2c-20e1-4030-8961-931a9af25ceb';

update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '776d450f-a30a-471c-be0b-4e90aac964bd';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'e1c1ba06-bcf0-40de-a0a4-0dd93abe3e6e';

update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'fc9878bd-1ddf-428b-99cd-ba8b2e4a189f';

update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '39a63645-9438-4e29-9a9b-18c7a28a3850';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '9e8bff1b-605f-4ffb-ae92-bab145fece9b';

update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '28bc95f6-34a2-40c5-bb77-f4fbebf3f5ff';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '9954edd0-42c3-403f-8656-c86180320cbc';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '36725067-7a06-423e-950b-04fa21ce4f00';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'e51f7d7c-ec72-4703-b552-57256bbf4f7d';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = 'e446d995-8169-4b77-94f8-033e489630d7';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'c27c6ce4-175f-4e60-be1d-c35ff6c2bbb1';

update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '7f76bb37-1b44-4093-af58-a482aaaff3ff';

update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '43af8e8c-6a96-4dd6-9352-9035230caeb5';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '99c7b113-fa44-4f79-ac42-be44e278c76e';

update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'd09f4035-937d-42ac-b39f-fa6466f45693';


update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '89866bfa-1736-46d8-b54b-348338941d74';

update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'ba07d8b2-042d-4bf3-8a8f-e4ca2eb8034e';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '7bc3c405-1278-48ac-b395-31e5ac23469b';

update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '9d354086-711d-403c-a426-5896a75f0b17';

update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '15682115-de3d-415c-9395-6b8717f9f07f';

update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '419e405d-66d1-4b91-9618-0eb091bf2697';

update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'e7aa182f-f147-470a-b149-39afec94c2e6';

update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '83c3c06d-f3a0-4a7b-aae5-7e3683160b34';


update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'f8a35cf7-9261-4c24-87b1-9aed7934f163';

update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '9d1e7c19-03e9-4fd3-b737-f0d064acc18b';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '359ccd01-e195-4447-8014-4bd86153d7d1';


update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '60b88cfc-7dd5-43e7-b70c-4972b716fdc1';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '4d5e094e-c9bf-4536-9c38-b43cdf6c5201';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '4dd22373-b067-4ce7-ac1e-ac868743c83f';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '5e4a80d8-9007-43cc-81d5-3f18fc39b4ee';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '5720f56d-01d2-469e-92e6-99719934628e';

update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '9a563be0-6ae4-4865-bb12-f0e2bda5ea25';

update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '4540af3e-e082-4a4b-9632-09889e43fa48';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '1245236a-bfca-4512-a9a5-6090d9344d0c';

update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '24f9a81b-b1e2-4012-89c3-86dde3caa7df';

update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '68b546cf-3f4a-4feb-a9dc-f470b749d5e6';

update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = 'ed049c6b-9dc0-458e-a376-e4059f3c9a62';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '20b10bcf-e226-4a69-bf93-7e8881d48e17';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '71f0eaa4-496a-4740-9e1a-ded1980733d2';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'c43fe1c2-b151-4c8d-87a3-e27bcef5503c';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '508fc907-719e-457a-9f39-bb93c97831f5';


update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '4a5529d2-0174-4030-afdd-4d0409ccf2d5';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'c09d7a36-6c0e-4506-bdfb-5ef02d212cd7';


update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '04c811c2-d7e0-46ab-9b74-593934d9cca1';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '2aa2cbe9-0aa9-4b07-8206-cfc41fd7e013';

update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '1d64c0a0-71be-49e9-b475-d53bb3fce7ff';


update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '40312657-5450-4152-a5e9-68e55da9d215';

update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'e9dd5945-572a-46cf-aaec-80620ee427ce';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'ec435c7b-7e27-4940-abbe-b200c1a23391';


update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '5439471d-88e4-4f0d-a009-19f91e01e728';

update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '50c0530e-5a6f-46a9-b127-0619bd3beb1e';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = 'c01e97f6-0c0b-4803-8c42-778bb4dbcac6';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'e4518869-9a1c-404b-8b24-750b405c3481';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = 'b5544a99-773d-4c68-8b56-01bc8354a46d';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '7ed94cd3-53fc-4dfa-ada1-565117eed61f';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'cb0b5630-433f-4e77-b683-2214e53651c2';

update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '95b15ff0-5bce-4ed9-ac40-97d224cfd8d4';

update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'd5c7e5f0-de2f-4e1c-abd4-38940c164589';


update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '88034d6c-d55d-473f-b4e6-fa82498a2ea9';

update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'eec13843-5337-430e-bbf6-38440b231a20';

update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'f43f5e74-3535-450c-8601-387953dc9db4';

update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'bb07fb91-446f-4a24-ba5e-03d03ef9a8e6';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '2a107fe6-c988-4aee-b912-a1f3bc529d50';


update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'f1560505-fba3-4dd0-a1b2-bd3c80d018c0';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = 'e9424a7a-0db1-4543-be1c-d25cccb19302';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'd9037627-dbb0-41e3-a66c-527ed198def8';

update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '6ff5bc00-f02f-4f62-9836-4e3a226c1808';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = 'b7c66d6f-3c7a-4d54-9222-eedbfda1727f';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'c3d1bb2d-3d0c-499f-98b7-d59a9e41d001';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '073b205d-36c5-44dd-8261-e5cbe8d906a9';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'f00d4128-a3f6-49bf-a49a-cdfb28061bd2';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '5bf3f8cd-5a6f-4aba-898e-50e120305abb';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'd101ab49-b0dd-47f0-a820-d7bdb424bf9d';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '051ee6c7-b680-4859-a8a7-0d7485806aa1';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '39b01fbb-24ce-410d-bf66-2a4cc3de24d0';

update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'd0371893-8fe8-47ac-bc5e-d820f9e9178d';

update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'af3070a4-1994-47a4-8e0a-2b1dfe6b36c8';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '26f563ae-51d7-49cd-a8ad-80051566e053';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'a0a3568a-440d-4774-b45c-0e400a0ba7b2';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '90c447ab-d290-4120-8199-2c53f02f5450';


update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'd0f86457-30a4-402e-b287-0607c2e2ca4e';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '21837664-5a88-4ead-9d9b-7dfae06934b2';


update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'a125ea82-b973-48b5-a8ee-3d40fab9abc1';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '744692bf-a8fd-4711-b050-5b0901e7dd3b';


update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '2b733ac1-1b68-42ae-a84c-56bcd2e7e021';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'dffd7646-ef03-4f78-b54d-5f781630385e';


update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'c9edcd32-ac7b-4d7c-9b43-8acdeb63b36c';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'd999a6bc-dc8c-4504-9ca5-0cfe970474fa';


update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '0f0942f6-2df0-4393-baea-cdd3cd180f42';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '0cb23e97-e825-4e06-9d02-5479ab7aa48c';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '93d02910-dad2-4bb4-8433-817b7c92c477';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '23a06b7b-9d0b-48b9-a442-c938732978ac';

update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '618ba911-6598-4ee5-99ae-79f2da7f6727';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '6c30645d-e306-4c13-8474-357cdb7c24d1';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '816157e2-2815-4ac3-b3d5-21c5453f9e26';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '301060fe-c50e-4194-b355-366a1f07ae9d';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'b9a1d7e3-414c-4e82-88e0-aa9680523326';


update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'c008760e-d8e6-4cf6-932d-638de312d0a7';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'b10e1c37-4d6a-4825-b2ba-5a438e75dc58';

update cjams.person set cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'da01338c-6d7c-4dbf-8609-e13dbdd77aea';

update cjams.person set cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'b5af8c61-e87b-42df-a588-c45be32584b8';

update cjams.person set cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '26e98589-7e58-4d59-ba1c-25ede25281e4';

update cjams.person set cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '38475d16-bd7f-4398-95d5-306c73339fba';

update cjams.person set cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '39d81a40-7fc3-438c-87a5-c222b92502c3';

update cjams.person set cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '92b0d544-746d-46c8-8d54-234fd5831970';

update cjams.person set cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '9d917f76-e244-40c1-8ee8-83f083c790fe';

update cjams.person set cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '0bded922-1561-479c-b63e-5accf188b85b';

update cjams.person set cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'a616936d-fecb-4dc6-af6e-bc3a5ac106eb';

update cjams.person set cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '277671d7-09d9-49dc-9413-5dd322d31d8b';

update cjams.person set cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '12aff8d1-0f88-44df-a32d-fb0fb41ec45c';

update cjams.person set cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '3ff4675d-6f35-442a-8341-68f021299591';

update cjams.person set cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '1f850a3b-ed02-4359-aea4-80f3f1dccbad';

update cjams.person set cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '17ca5bcd-50e2-45af-b1d3-055fc786ebd0';

update cjams.person set cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '8c6a8ef7-75d6-45a7-b6e7-d4d0392f6179';

update cjams.person set cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '4230d4d5-c4bd-4b21-bc25-d12959748816';

update cjams.person set cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '86243708-737b-4525-ba50-9fca3a1043d5';

update cjams.person set cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'd83a48b5-860a-41a7-a98c-d5bc756088e1';

update cjams.person set cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'f73795ae-b871-4174-88b9-befd58c051cd';

update cjams.person set cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '94209026-5de5-44bd-a548-d2dfb58f4814';

update cjams.person set cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '0e04c868-968f-4bb8-a266-816e03b61299';

update cjams.person set cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'bfc035d9-3744-4b89-afc0-f9a240730b71';

update cjams.person set cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'c43c775d-f699-4f72-886f-1c3251f215c9';

update cjams.person set cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'e757d84a-e4b8-49c2-87fd-9dd941d2b424';

update cjams.person set cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '8e0190af-045e-4376-8cff-adc0788813cf';

update cjams.person set cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '18a51317-e886-42b7-847e-7eb1e0a51149';

update cjams.person set cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '4e98b88d-6945-47d9-9075-6f198db4bf06';

update cjams.person set cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'b285ebbb-3b44-4050-b2c1-82851b296280';

update cjams.person set cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '2bf1b0d4-3c10-441a-b111-9134e966ad0c';

update cjams.person set cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'c7906876-967f-4e81-9da3-c734708a5995';

update cjams.person set cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '38d574a8-4ac7-4e22-8247-58b4e4ff2ab7';

update cjams.person set cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'e9c36463-8948-4e00-a2af-a94083861c8d';

update cjams.person set cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '81378cc6-6db3-4025-811c-b62f385a939f';

update cjams.person set cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '69d45fd9-7b95-42e0-8027-6341e8af2e18';

update cjams.person set cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '92a9d2fe-58a5-404b-b472-d46f5bb5b03b';

update cjams.person set cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '68be1829-c771-4302-b2f1-13ce2db7e318';

update cjams.person set cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'd63453f9-30db-41e6-bed7-8c9fba2cb4e1';

update cjams.person set cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '276fdac2-5473-405b-963f-ff1a05580f4e';

update cjams.person set cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '2d705b80-70a2-4652-aa5e-b4ff7468ce44';

update cjams.person set cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'c507a74d-0eb5-4308-9489-393914eec87a';

update cjams.person set cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '0c47f8cd-3aef-494f-bbf3-4ad6a3225dee';

update cjams.person set cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'cf1721bf-ec3c-472e-82fd-b8038a44b490';

update cjams.person set cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '0a7ddc9f-eb04-45bc-9280-5f3ace895f09';


update cjams.person set cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '47955c66-ef0c-4ab8-87e4-6f2fb111f292';
update cjams.person set cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '2bf8ce9e-d568-46db-b9ef-c4892dff07da';

update cjams.person set cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '36c2546f-f376-46cc-8137-8f6cbab40ee4';

update cjams.person set cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '99b42417-fb60-4970-b705-6d4c5deabdd4';

update cjams.person set cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'fedcccfb-556e-4384-8a1c-c1cf3ddf1261';

update cjams.person set cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '9a333755-eece-4945-8b6f-6d7d2f7ecf12';

update cjams.person set cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'd56ee362-0003-4640-8158-8b5094bb975e';

update cjams.person set cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'bd835404-7650-4886-87ef-c37c71ea319c';

update cjams.person set cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'f3253172-0481-4d7f-9702-244b4e05c93c';

update cjams.person set cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'ada28c0a-45b7-4844-a1a7-2803b2284790';

update cjams.person set cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '2256f721-e237-48f5-9bbe-0ea228b90c6e';

update cjams.person set cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '4194177d-edb4-4b16-ad34-1a44ebd8d6d9';

update cjams.person set cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '3447b645-5965-4363-918b-620e1ac000d7';

update cjams.person set cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '0f7204bd-7c28-4aa7-a6b4-4e98a1f03025';

update cjams.person set cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '1292749c-e7fb-4178-b7ea-713c91a519ef';

update cjams.person set cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '2939ff0c-f45c-4d1c-955d-d9431baad569';

update cjams.person set cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '9c73c1b9-40bf-442b-add4-d1cbfb3f139f';

update cjams.person set cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '8e02ce15-92c9-411c-bba7-d05d92420490';

update cjams.person set cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '520eb5bd-4080-4d95-a5e0-5fa2ea4dd176';

update cjams.person set cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'b76ede36-6a46-4eca-b7d6-3a06ed221959';

update cjams.person set cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'a410c423-b294-462a-a914-fe1e11308533';

update cjams.person set cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'f083bb4a-4f24-49dd-92c5-45a3fe165774';

update cjams.person set cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '7d4919ab-392c-413a-a69d-dfa27f625e4a';

update cjams.person set cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '29e6e561-9d92-4b83-9e9a-38f80b530341';

update cjams.person set cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '118ae780-e162-4487-95b9-96cedc0884ab';

update cjams.person set cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '63cfe9e7-1fa1-4be1-9a86-2686a42b9bf6';

update cjams.person set cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '5d1162ec-a1b3-4794-a2ba-914be204d7dc';

update cjams.person set cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'b82cd19e-a3d2-4c31-b448-001b1cfedec5';

update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '72b474b7-910f-4d24-bae5-f4a8e7896948';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'fd90898c-0b15-4539-85c5-248eddd5aed9';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = 'd1a52b03-64e7-457b-b08a-13c0af4d0a51';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '958e93f1-ad8b-4c86-847e-ea500745d1b6';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = 'fb19d3e2-cc5f-4331-9e24-8a9b90e427c7';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '936d852f-f581-4f6d-be16-807a82e891d0';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '62b37288-4359-4873-ac5c-02d1625c1a7f';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'dd52b2bb-27ba-4df3-8ed8-433716512298';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = 'e35b05b2-4812-459a-a1bd-004c8eefc344';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'adbf4e67-eada-4620-a02c-48b619314f4e';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = 'd5349dd1-355c-4339-b3ee-5c9076c661f6';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'bdcdeb0c-5ad7-431a-ae08-5ef6a31321a3';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '0f60831e-4bf7-4746-a571-c8a832a17229';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '34583d9a-116c-4db2-8f64-6eef41f10b9a';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = 'a72bc253-4b92-477a-8e9d-4a719c75fe18';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '3dd97bef-d736-4085-b4a8-0536d2a429e8';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = 'e3693d1b-8cc6-4434-ac9d-87fa801dfbdf';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '93179279-103d-4fc3-acd9-e35be9341f7a';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = 'fdddd18a-a184-47f0-b13e-90c7e466f8d0';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '3846924b-1c73-4efb-8347-11c6e094a0c9';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = 'f1d5725b-2a13-456e-8abe-ec7c86efe9b4';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'e9c4222c-51d2-4a4c-803e-946fc1fb4af0';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '8e271a7b-77a0-466c-a3ce-9a3c00b3c0b6';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '0911249b-3338-4eca-8647-77026ddf4bb5';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '43e77939-9c99-4c85-b73f-78345a8e15e8';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '6f167684-8964-41ae-8707-e9202209c782';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = 'd21352bf-0d46-4f21-848e-d9ff53861eda';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'bca5ebd5-0f0a-46b6-a8a4-9670b44785df';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '50a483ba-6a17-4c72-a599-aa4ce55b5f24';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '2c429743-3088-437d-bcf4-854a6c0a067e';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '76628b9b-1357-4c0e-a706-d0a265819758';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'acc25997-57c1-49f4-b0ec-ff71f420aa98';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = 'f70c42cf-d1c8-448b-92ca-cb1138ba57b3';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '9fde9697-7734-4894-a819-ae10937b96bb';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = 'bcbc808d-e596-47d1-9d5a-974297aed871';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '2b0dff67-5ce6-4ab9-9049-058e89b7581b';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '6b5b36ef-8b13-42cc-906d-4b6ad15c62c9';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '6ae86731-04c8-443c-913c-74707a10e55e';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '00954070-b2bc-4973-80e8-8f34f1d4998b';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'ad1c0ef9-b551-476c-979f-4a9da6de81b6';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '55438cae-32c3-4374-8027-348e936d69d8';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '51c5dfc9-09f6-4a12-bb42-783a494af52f';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = 'a4a482fd-ad2d-431d-a248-5ed419ca473b';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'e667158d-b004-4643-ab08-e8f24a3237f3';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = 'f73f57b7-f500-4858-a2a3-523786fe865a';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '34eec41a-638a-4e4c-8c13-77644113c628';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '1bc0ac08-3cc8-4f33-9097-9df2d687d298';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '09ba0b4a-3686-4eb3-8ed0-b6479b876e1a';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '4428ef5b-b370-497d-8b4f-d1d3cc85b9e2';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '1fec1928-6444-44f0-acb3-e62ea80ec266';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '86523c1d-d5d6-4c61-a645-14c90a5a5db1';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '298b34bc-1590-4efe-b312-f432a9698972';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = 'f0f79337-63ad-4dbc-8188-4805b5253ae2';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '7c6f0b25-29c3-4238-a444-888775f8236d';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '8e76ed11-a5be-4bd2-8d7c-0c74d5a85bc8';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '459e91de-a8c1-4e0c-b0ba-df0fc568529d';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '9506b61b-0947-47ac-ba04-be6ddaab09c6';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'f1a64094-2c98-4656-9152-003930070338';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '02389559-f075-4c39-8c4c-ed5c164ef4a2';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '89c5b93a-3dbe-4650-a2ed-ceed14f84bf0';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = '31396123-b3b7-4c63-a445-ee25b48352de';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'dd02a585-c5c9-4039-859d-b0f5be936c73';
update cjams.person set activeflag = 0, updatedon = now(), updatedby = 'CIDM-7908' where personid = 'e49e4b57-5f4c-4373-a820-cdc794268a4b';
update cjams.person set activeflag = 0, cjamspid = nextval('cjams.sequence_for_alpha_numerics'::regclass), updatedon = now(), updatedby = 'CIDM-7908' where personid = '2c3cd780-d018-49ea-88fb-df4591520409';


update cjams.adoptioncaseactor set personid = (select personid from cjams.person where cjamspid = 200134955 limit 1), updatedon = now(), updatedby = 'CIDM-7908' where personid = '7547f434-f60e-4821-9b60-6d6ec571b0f6';

update cjams.adoptioncaseactor set personid = (select personid from cjams.person where cjamspid = 200106161 limit 1), updatedon = now(), updatedby = 'CIDM-7908' where personid = '0b096cb4-b4ae-437e-9f41-844713a7f71f';

update cjams.adoptioncaseactor set personid = (select personid from cjams.person where cjamspid = 200124560 limit 1), updatedon = now(), updatedby = 'CIDM-7908' where personid = '89866bfa-1736-46d8-b54b-348338941d74';

update cjams.adoptioncaseactor set personid = (select personid from cjams.person where cjamspid = 200111678 limit 1), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'ba07d8b2-042d-4bf3-8a8f-e4ca2eb8034e';

update cjams.adoptioncaseactor set personid = (select personid from cjams.person where cjamspid = 200122609 limit 1), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'eec13843-5337-430e-bbf6-38440b231a20';

update cjams.adoptioncaseactor set personid = (select personid from cjams.person where cjamspid = 200124750 limit 1), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'bb07fb91-446f-4a24-ba5e-03d03ef9a8e6';

update cjams.adoptioncaseactor set personid = (select personid from cjams.person where cjamspid = 200103753 limit 1), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'd0371893-8fe8-47ac-bc5e-d820f9e9178d';

update cjams.adoptioncaseactor set personid = (select personid from cjams.person where cjamspid = 200129739 limit 1), updatedon = now(), updatedby = 'CIDM-7908' where personid = 'd0f86457-30a4-402e-b287-0607c2e2ca4e';