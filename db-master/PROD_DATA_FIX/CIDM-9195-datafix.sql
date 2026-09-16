/*
  Issue Description:CIDM-9195
Category/ Module:Application
Root cause: Data cleanup activities done for the following
Provider Not involved, School and Daycare, ProviderInvolved with data.
Pull request# for code fix:
Reason why no related code fix:
Status of the code fix if already submitted and expected prod fix date:
   Backup before update/ delete: 
*/

-----Provider Not involved

 ----2021048082729
update investigationallegation set isproviderinvolved = 0, 
updatedby = 'CIDM-9195',  updatedon = now() 
where investigationallegationid in  ('83f12c23-c2cc-4ebe-96a9-ce7d16258dd4', '5961f28c-5a6e-40be-8de3-333dd75a0086' )
and coalesce(isproviderinvolved, 1) = 1  and activeflag = 1 ;

update investigationallegation set isproviderinvolved = 0, 
updatedby = 'CIDM-9195',  updatedon = now() 
where investigationallegationid =  'c2f299d7-7582-4ce9-a15b-face023279c3' 
and coalesce(isproviderinvolved, 1) = 1  and activeflag = 1 ;


-----231020836286
update investigationallegation set isproviderinvolved = 0, 
updatedby = 'CIDM-9195',  updatedon = now() 
where investigationallegationid in ('09063fa8-40c1-4591-bc55-08bdddb249a1','af59809e-9d27-47df-80d5-c98fc6b21eee','b9852a51-bd43-4b24-a487-1cfb5fa24bba','c1a4083c-c6fe-4959-a20a-34a6e22b0ad5','fee2c3f3-a28a-4773-8998-970ae662cac2','83885d03-8a7a-4bff-8a3b-65dbba74cef8','bf57d125-84e8-4be7-9e72-c00fa8ab2840',
'e72e38bd-acc3-40b7-aa33-b51ee166968c','bf73d2b1-2790-4a73-bbf4-a877b4c4fb62')   
and coalesce(isproviderinvolved, 1) = 1  and activeflag = 1 ;

------221020181876

update investigationallegation set isproviderinvolved = 0, 
updatedby = 'CIDM-9195',  updatedon = now() 
where investigationallegationid in ('5f98e3c6-3a19-46ec-86ba-42dcda3e52c3','ee8e38b8-0a2f-4eb2-be24-2e62c388c39d',
'223e97c6-6aa2-4e15-8a2b-9d3bc3cb3125',
'b847e9b3-48a1-4e63-b53a-cf6d36c55a6b','e9b77dbb-e914-43e9-a9f3-62c20903aaf3','783d154e-c4fe-4345-a38d-2c37da8905ef')
 and coalesce(isproviderinvolved, 1) = 1  and activeflag = 1 ;

update investigationallegation set isproviderinvolved = 0, 
updatedby = 'CIDM-9195',  updatedon = now() 
where investigationallegationid ='e89cd7b3-79ab-4135-9ea4-8079d8b1f297'
 and coalesce(isproviderinvolved, 1) = 1  and activeflag = 1 ;

update investigationallegation set isproviderinvolved = 0, 
updatedby = 'CIDM-9195',  updatedon = now() 
where investigationallegationid ='dfa41629-508a-4c1a-908e-9f80ae11dbd1'
 and coalesce(isproviderinvolved, 1) = 1  and activeflag = 1 ;

update investigationallegation set isproviderinvolved = 0, 
updatedby = 'CIDM-9195',  updatedon = now() 
where investigationallegationid ='f2d5c5a3-b5c8-4e16-8054-57db1e85382c'
 and coalesce(isproviderinvolved, 1) = 1  and activeflag = 1 ;

---241021814236 correct data 

----241021814236

update investigationallegation set isproviderinvolved = 0, 
updatedby = 'CIDM-9195',  updatedon = now() 
where investigationallegationid in ('a7f35f6e-3612-4d2b-a068-07315ca69108','802760ed-e710-4c9d-adc3-fffb5fad17d6')
 and coalesce(isproviderinvolved, 1) = 1  and activeflag = 1 ;

update investigationallegation set isproviderinvolved = 0, 
updatedby = 'CIDM-9195',  updatedon = now() 
where investigationallegationid ='8c41079c-102e-4cd1-a51b-0f95e715eb0a'
 and coalesce(isproviderinvolved, 1) = 1  and activeflag = 1 ;

----241021916481 correct data 

---241021923413 correct data 


update investigationallegation set isproviderinvolved = 0, 
updatedby = 'CIDM-9195',  updatedon = now() 
where investigationallegationid ='b1499367-572a-458d-ab9c-bd3e8b9415a4'
 and coalesce(isproviderinvolved, 1) = 1  and activeflag = 1 ;

update investigationallegation set isproviderinvolved = 0, 
updatedby = 'CIDM-9195',  updatedon = now() 
where investigationallegationid in ('a0551777-0f40-4e7c-aac0-805efd79cc9c',
'9d5c5814-48d4-48ad-a947-ae9f0160fcb2','c6e26115-cf06-48f4-a456-81521ea59368')
 and coalesce(isproviderinvolved, 1) = 1  and activeflag = 1 ;

update investigationallegation set isproviderinvolved = 0, 
updatedby = 'CIDM-9195',  updatedon = now() 
where investigationallegationid in ('dbed5a25-c64e-48de-a852-69dd047acead',
'bd72091e-be8e-490f-a0f8-93f7972887ce')
 and coalesce(isproviderinvolved, 1) = 1  and activeflag = 1 ;

-----School and Daycare------
update allegationprovidermaltreatment set providermaltreatmenttypekey = 'SCL', updatedby ='CIDM-9195', updatedon = now()
where investigationallegationid ='4d64bf2c-6526-4fc9-89d2-3094bb1e8811' and activeflag =1;

INSERT INTO cjams.allegationprovidermaltreatment  values 
(cjams.gen_random_uuid(),  'd1356688-575f-4649-bc78-e4c0724f88e9' , 'LUD', 1, 'CIDM-9195', 'CIDM-9195', now(), now(), now(), null);


INSERT INTO cjams.allegationprovidermaltreatment  values 
(cjams.gen_random_uuid(),  '47e4820d-5f7c-4477-b86f-6a8d710254d6' , 'SCL', 1, 'CIDM-9195', 'CIDM-9195', now(), now(), now(), null);

update allegationprovidermaltreatment set providermaltreatmenttypekey = 'LUD', updatedby ='CIDM-9195', updatedon = now()
where investigationallegationid in ('5f18a544-3235-43f6-b324-1b2d074a20d2','38edf4e8-5daa-4f5a-ac1f-b6a4f5f9c138') and activeflag =1;

INSERT INTO cjams.allegationprovidermaltreatment  values 
(cjams.gen_random_uuid(),  'ec121849-ddd0-4732-97a2-899ccf5feaeb' , 'LUD', 1, 'CIDM-9195', 'CIDM-9195', now(), now(), now(), null);

INSERT INTO cjams.allegationprovidermaltreatment  values 
(cjams.gen_random_uuid(),  '892bf6c2-1966-4d57-b59d-089eababfe6b' , 'SCL', 1, 'CIDM-9195', 'CIDM-9195', now(), now(), now(), null);

INSERT INTO cjams.allegationprovidermaltreatment  values 
(cjams.gen_random_uuid(),  '79736300-091a-4bb3-b8ef-9af0c6574478' , 'LUD', 1, 'CIDM-9195', 'CIDM-9195', now(), now(), now(), null);

INSERT INTO cjams.allegationprovidermaltreatment  values 
(cjams.gen_random_uuid(),  'f6722d29-79d5-41f5-a558-7c050b953cd7' , 'LUD', 1, 'CIDM-9195', 'CIDM-9195', now(), now(), now(), null);

INSERT INTO cjams.allegationprovidermaltreatment  values 
(cjams.gen_random_uuid(),  'aac7d5ae-e3b9-4dd2-98eb-ff5a2b959f6f' , 'SCL', 1, 'CIDM-9195', 'CIDM-9195', now(), now(), now(), null);

INSERT INTO cjams.allegationprovidermaltreatment  values 
(cjams.gen_random_uuid(),  'a1ce30d0-8139-49a9-8d1e-798cc078fdd0' , 'SCL', 1, 'CIDM-9195', 'CIDM-9195', now(), now(), now(), null);

INSERT INTO cjams.allegationprovidermaltreatment  values 
(cjams.gen_random_uuid(),  'da865be7-a2e8-4f24-9dc9-dd72e2c02882' , 'SCL', 1, 'CIDM-9195', 'CIDM-9195', now(), now(), now(), null);

INSERT INTO cjams.allegationprovidermaltreatment  values 
(cjams.gen_random_uuid(),  '45db9e1b-be2a-4f72-8d4a-cab65caeeca5' , 'LUD', 1, 'CIDM-9195', 'CIDM-9195', now(), now(), now(), null);

INSERT INTO cjams.allegationprovidermaltreatment  values 
(cjams.gen_random_uuid(),  '02e6ba58-e550-4cc9-9d72-f408aa9b0b43' , 'LUD', 1, 'CIDM-9195', 'CIDM-9195', now(), now(), now(), null);

INSERT INTO cjams.allegationprovidermaltreatment  values 
(cjams.gen_random_uuid(),  '16d4fffe-bdc3-4cd5-8e7b-226bf6ff876d' , 'LUD', 1, 'CIDM-9195', 'CIDM-9195', now(), now(), now(), null);

INSERT INTO cjams.allegationprovidermaltreatment  values 
(cjams.gen_random_uuid(),  '0e372a6d-e31d-435f-9135-329449891ed4' , 'LUD', 1, 'CIDM-9195', 'CIDM-9195', now(), now(), now(), null);

INSERT INTO cjams.allegationprovidermaltreatment  values 
(cjams.gen_random_uuid(),  '6d879403-68a1-454a-80f8-903f3bbb5d43' , 'SCL', 1, 'CIDM-9195', 'CIDM-9195', now(), now(), now(), null);
 
INSERT INTO cjams.allegationprovidermaltreatment  values 
(cjams.gen_random_uuid(),  '637365e7-7bfc-470f-a074-d93b499d8974' , 'LUD', 1, 'CIDM-9195', 'CIDM-9195', now(), now(), now(), null);
 
INSERT INTO cjams.allegationprovidermaltreatment  values 
(cjams.gen_random_uuid(),  'f371c5c8-d975-4c81-9b71-664cafdb4f7d' , 'LUD', 1, 'CIDM-9195', 'CIDM-9195', now(), now(), now(), null);
 
INSERT INTO cjams.allegationprovidermaltreatment  values 
(cjams.gen_random_uuid(),  '65009c39-3c9d-4d2a-8a27-348344042e08' , 'LUD', 1, 'CIDM-9195', 'CIDM-9195', now(), now(), now(), null);

INSERT INTO cjams.allegationprovidermaltreatment  values 
(cjams.gen_random_uuid(),  '032a7835-100d-464a-9e16-ae2379167c48' , 'LUD', 1, 'CIDM-9195', 'CIDM-9195', now(), now(), now(), null);

INSERT INTO cjams.allegationprovidermaltreatment  values 
(cjams.gen_random_uuid(),  'bb5d538c-51b0-4c30-af91-ac3684dd7761' , 'SCL', 1, 'CIDM-9195', 'CIDM-9195', now(), now(), now(), null);

INSERT INTO cjams.allegationprovidermaltreatment  values 
(cjams.gen_random_uuid(),  '52d1d448-c1e8-4056-bb1b-341177687294' , 'SCL', 1, 'CIDM-9195', 'CIDM-9195', now(), now(), now(), null);

INSERT INTO cjams.allegationprovidermaltreatment  values 
(cjams.gen_random_uuid(),  'd2ec3842-fa7a-4da8-974c-bb770a7e4ea8' , 'SCL', 1, 'CIDM-9195', 'CIDM-9195', now(), now(), now(), null);


INSERT INTO cjams.allegationprovidermaltreatment  values 
(cjams.gen_random_uuid(),  '707f06a2-ca24-4103-bfde-95d326d2f377' , 'LUD', 1, 'CIDM-9195', 'CIDM-9195', now(), now(), now(), null);

INSERT INTO cjams.allegationprovidermaltreatment  values 
(cjams.gen_random_uuid(),  'ae53e40e-5cab-4c4a-a08b-55f5bced9838' , 'LUD', 1, 'CIDM-9195', 'CIDM-9195', now(), now(), now(), null);

INSERT INTO cjams.allegationprovidermaltreatment  values 
(cjams.gen_random_uuid(),  'ad7d3a05-58ff-4b2d-b77a-7ac18e58038c' , 'LUD', 1, 'CIDM-9195', 'CIDM-9195', now(), now(), now(), null);

INSERT INTO cjams.allegationprovidermaltreatment  values 
(cjams.gen_random_uuid(),  '1c1837b5-6c1d-43b1-a5f0-bdba522c7452' , 'SCL', 1, 'CIDM-9195', 'CIDM-9195', now(), now(), now(), null);

INSERT INTO cjams.allegationprovidermaltreatment  values 
(cjams.gen_random_uuid(),  '8ba49440-2a08-48e0-a2f2-1e9f99312dee' , 'LUD', 1, 'CIDM-9195', 'CIDM-9195', now(), now(), now(), null);

INSERT INTO cjams.allegationprovidermaltreatment  values 
(cjams.gen_random_uuid(),  '582039a6-0298-41ff-9e1b-935e66c9663f' , 'LUD', 1, 'CIDM-9195', 'CIDM-9195', now(), now(), now(), null);

INSERT INTO cjams.allegationprovidermaltreatment  values 
(cjams.gen_random_uuid(),  '65d6b23b-df91-4627-bc5b-0d24f0d3dcd6' , 'SCL', 1, 'CIDM-9195', 'CIDM-9195', now(), now(), now(), null);

INSERT INTO cjams.allegationprovidermaltreatment  values 
(cjams.gen_random_uuid(),  '8b9bcd29-4be2-429d-9a23-d49b0ef11f93' , 'SCL', 1, 'CIDM-9195', 'CIDM-9195', now(), now(), now(), null);

INSERT INTO cjams.allegationprovidermaltreatment  values 
(cjams.gen_random_uuid(),  '3cf0be42-508d-408a-9932-1b4c2866102c' , 'SCL', 1, 'CIDM-9195', 'CIDM-9195', now(), now(), now(), null);

INSERT INTO cjams.allegationprovidermaltreatment  values 
(cjams.gen_random_uuid(),  '1e93f2e0-90de-42b1-95d7-a691983637d4' , 'LUD', 1, 'CIDM-9195', 'CIDM-9195', now(), now(), now(), null);

INSERT INTO cjams.allegationprovidermaltreatment  values 
(cjams.gen_random_uuid(),  '1302b9f9-f48e-4d14-9daf-2b1eacac1388' , 'LUD', 1, 'CIDM-9195', 'CIDM-9195', now(), now(), now(), null);

INSERT INTO cjams.allegationprovidermaltreatment  values 
(cjams.gen_random_uuid(),  '89b1c23e-42ca-42e8-a2c8-5d867212ba72' , 'SCL', 1, 'CIDM-9195', 'CIDM-9195', now(), now(), now(), null);

INSERT INTO cjams.allegationprovidermaltreatment  values 
(cjams.gen_random_uuid(),  '3ff610ed-9407-4fec-ae14-f36d2f153c12' , 'SCL', 1, 'CIDM-9195', 'CIDM-9195', now(), now(), now(), null);

INSERT INTO cjams.allegationprovidermaltreatment  values 
(cjams.gen_random_uuid(),  '4f221f25-8338-46e4-bb7a-9ee1593c2d38' , 'SCL', 1, 'CIDM-9195', 'CIDM-9195', now(), now(), now(), null);

INSERT INTO cjams.allegationprovidermaltreatment  values 
(cjams.gen_random_uuid(),  '8c34632c-928f-4765-81d0-30c870417d88' , 'SCL', 1, 'CIDM-9195', 'CIDM-9195', now(), now(), now(), null);

-----No record found---- 231020483109

 INSERT INTO cjams.allegationprovidermaltreatment  values 
(cjams.gen_random_uuid(),  'f76373ba-0cea-49c4-8b86-ba5f0a7a2011' , 'SCL', 1, 'CIDM-9195', 'CIDM-9195', now(), now(), now(), null);
 
INSERT INTO cjams.allegationprovidermaltreatment  values 
(cjams.gen_random_uuid(),  'ab5a0104-7a37-403c-819e-946193202a12' , 'LUD', 1, 'CIDM-9195', 'CIDM-9195', now(), now(), now(), null);

INSERT INTO cjams.allegationprovidermaltreatment  values 
(cjams.gen_random_uuid(),  '2caa4b04-4b8c-4dd9-bd1f-7a8db5582116' , 'SCL', 1, 'CIDM-9195', 'CIDM-9195', now(), now(), now(), null);

INSERT INTO cjams.allegationprovidermaltreatment  values 
(cjams.gen_random_uuid(),  '53946131-94d1-422b-b987-dff132d3c1f9' , 'SCL', 1, 'CIDM-9195', 'CIDM-9195', now(), now(), now(), null);

INSERT INTO cjams.allegationprovidermaltreatment  values 
(cjams.gen_random_uuid(),  'a29d2a07-30d5-4321-b4ad-ad4a97f1cc98' , 'SCL', 1, 'CIDM-9195', 'CIDM-9195', now(), now(), now(), null);

INSERT INTO cjams.allegationprovidermaltreatment  values 
(cjams.gen_random_uuid(),  'ba0114d7-87d5-4fd1-925d-f046844b77f5' , 'SCL', 1, 'CIDM-9195', 'CIDM-9195', now(), now(), now(), null);

INSERT INTO cjams.allegationprovidermaltreatment  values 
(cjams.gen_random_uuid(),  '813e4992-d825-4c75-9607-f31dbc5c4a6e' , 'SCL', 1, 'CIDM-9195', 'CIDM-9195', now(), now(), now(), null);

INSERT INTO cjams.allegationprovidermaltreatment  values 
(cjams.gen_random_uuid(),  'eefc911a-1727-4b2b-8c54-a26f0b31c2d0' , 'SCL', 1, 'CIDM-9195', 'CIDM-9195', now(), now(), now(), null);

INSERT INTO cjams.allegationprovidermaltreatment  values 
(cjams.gen_random_uuid(),  '5b1a1c48-6d57-423f-958f-facfc2dee553' , 'SCL', 1, 'CIDM-9195', 'CIDM-9195', now(), now(), now(), null);

INSERT INTO cjams.allegationprovidermaltreatment  values 
(cjams.gen_random_uuid(),  '9674a732-fbaf-4924-b512-2d0a578e55be' , 'SCL', 1, 'CIDM-9195', 'CIDM-9195', now(), now(), now(), null);

INSERT INTO cjams.allegationprovidermaltreatment  values 
(cjams.gen_random_uuid(),  '105b12a8-e45d-4d22-8728-4dc7c4afc8bd' , 'LUD', 1, 'CIDM-9195', 'CIDM-9195', now(), now(), now(), null);

----------Provider Involved with data

-- 221020231396
INSERT INTO cjams.allegationprovidermaltreatment  values 
(cjams.gen_random_uuid(),  '3fbdabb0-191b-42eb-ae95-cb4f014903c7' , 'PP', 1, 'CIDM-9195', 'CIDM-9195', now(), now(), now(), null);


--221020237677(no record found)

---221020253437
INSERT INTO cjams.allegationprovidermaltreatment  values 
(cjams.gen_random_uuid(),  '2fb2843f-65d0-4bb1-bc8a-0f0cbf66a93a' , 'PP', 1, 'CIDM-9195', 'CIDM-9195', now(), now(), now(), null);

---221020253846
update investigationmaltreatment 
set providerid = 1574912, providername = 'University of Maryland Inpatient Psychiatric Hospital',  providerphonenumber = '', 
updatedby = 'CIDM-9195',  updatedon = now() 
where maltreatmentid =  '03e4bce3-6d95-4b1e-910e-ff01b3814023' and activeflag = 1;

INSERT INTO cjams.allegationprovidermaltreatment  values 
(cjams.gen_random_uuid(),  '040511bb-d158-4476-9f76-242049918bea' , 'LAFC', 1, 'CIDM-9195', 'CIDM-9195', now(), now(), now(), null);

--221020273107
INSERT INTO cjams.allegationprovidermaltreatment  values 
(cjams.gen_random_uuid(),  'a9236965-f549-4994-814b-c4e67ebb31ad' , 'FCPS', 1, 'CIDM-9195', 'CIDM-9195', now(), now(), now(), null);

---231020366214
update investigationmaltreatment 
set providerid = 6003614, providername = 'Jurian Thomas',  providerphonenumber = '', 
updatedby = 'CIDM-9195',  updatedon = now() 
where maltreatmentid =  '8e3c68de-4e02-4fd5-a380-a279b66f7bd7' and activeflag = 1;

INSERT INTO cjams.allegationprovidermaltreatment  values 
(cjams.gen_random_uuid(),  '4d98c350-1aba-4ab2-82ec-2adc543e7fd5' , 'FCPS', 1, 'CIDM-9195', 'CIDM-9195', now(), now(), now(), null);

---231021026840
update investigationmaltreatment 
set providerid = 5077021, providername = 'MAGIC Unity',  providerphonenumber = '', 
updatedby = 'CIDM-9195',  updatedon = now() 
where maltreatmentid =  '18939379-fb97-41a5-afce-5a5daf39ad4d' and activeflag = 1;

INSERT INTO cjams.allegationprovidermaltreatment  values 
(cjams.gen_random_uuid(),  'efab7f7f-4f1a-4d4c-9b99-ba581bd2a791' , 'PP', 1, 'CIDM-9195', 'CIDM-9195', now(), now(), now(), null);

---231021029515
INSERT INTO cjams.allegationprovidermaltreatment  values 
(cjams.gen_random_uuid(),  'd90f915d-2fd8-44b8-b48e-bf6661370c37' , 'PP', 1, 'CIDM-9195', 'CIDM-9195', now(), now(), now(), null);

---231021132157
INSERT INTO cjams.allegationprovidermaltreatment  values 
(cjams.gen_random_uuid(),  '9ee0abea-41a0-45ee-acce-2413a770bbb0' , 'PP', 1, 'CIDM-9195', 'CIDM-9195', now(), now(), now(), null);

---231021193021

update investigationmaltreatment 
set providerid = 6023332, providername = 'Fernando Jones',  providerphonenumber = '', 
updatedby = 'CIDM-9195',  updatedon = now() 
where maltreatmentid =  'a14bafa7-4793-4700-8562-6f0d79c92d83' and activeflag = 1;

INSERT INTO cjams.allegationprovidermaltreatment  values 
(cjams.gen_random_uuid(),  '133ef076-9b8a-4556-8c7d-b69d34253d3a' , 'FCPS', 1, 'CIDM-9195', 'CIDM-9195', now(), now(), now(), null);


---231021306670
INSERT INTO cjams.allegationprovidermaltreatment  values 
(cjams.gen_random_uuid(),  '5fb91096-3da7-4a2f-8727-9525afbc9ee5' , 'PP', 1, 'CIDM-9195', 'CIDM-9195', now(), now(), now(), null);

---231021474063

INSERT INTO cjams.allegationprovidermaltreatment  values 
(cjams.gen_random_uuid(),  'f6e61af1-44a6-4c57-8225-cf8bbadb02a9' , 'PP', 1, 'CIDM-9195', 'CIDM-9195', now(), now(), now(), null);

---231021484104
update investigationmaltreatment 
set providerid = 5090757, providername = 'Nexus-Woodbourne Family Healing- DETP - CSE',  providerphonenumber = '', 
updatedby = 'CIDM-9195',  updatedon = now() 
where maltreatmentid =  '2bb88d87-f1ad-43c2-80a7-6776d56fa00d' and activeflag = 1;

INSERT INTO cjams.allegationprovidermaltreatment  values 
(cjams.gen_random_uuid(),  'fa81d8df-7d14-456a-84b8-66c3facdca91' , 'PP', 1, 'CIDM-9195', 'CIDM-9195', now(), now(), now(), null);

---241021902950
INSERT INTO cjams.allegationprovidermaltreatment  values 
(cjams.gen_random_uuid(),  '66bcd49f-9152-4cb8-8956-d2b95949c820' , 'PP', 1, 'CIDM-9195', 'CIDM-9195', now(), now(), now(), null);

---231020845638

INSERT INTO cjams.allegationprovidermaltreatment  values 
(cjams.gen_random_uuid(),  'cb989598-db10-45be-92bc-296546b1a295' , 'LAFC', 1, 'CIDM-9195', 'CIDM-9195', now(), now(), now(), null);

---231021281034
update investigationmaltreatment 
set providerid = 1741659, providername = 'Nexus-Woodbourne Family Healing - Treatment Foster Care -1301 Woodbourne',  providerphonenumber = '', 
updatedby = 'CIDM-9195',  updatedon = now() 
where maltreatmentid =  '75bb4a04-e38a-4ede-9560-a21fc84af197' and activeflag = 1;

INSERT INTO cjams.allegationprovidermaltreatment  values 
(cjams.gen_random_uuid(),  '3b6c18ea-66fb-446e-8d15-556e47f3fa16' , 'FCPS', 1, 'CIDM-9195', 'CIDM-9195', now(), now(), now(), null);

---231021684277
INSERT INTO cjams.allegationprovidermaltreatment  values 
(cjams.gen_random_uuid(),  '81b004db-6b0d-4483-9772-d0f0f4eb5bbc' , 'PP', 1, 'CIDM-9195', 'CIDM-9195', now(), now(), now(), null);

-----241021880241
INSERT INTO cjams.allegationprovidermaltreatment  values 
(cjams.gen_random_uuid(),  'bf29abed-bd8d-4f85-82f7-ea0c00035bde' , 'PP', 1, 'CIDM-9195', 'CIDM-9195', now(), now(), now(), null);

----231020817651
INSERT INTO cjams.allegationprovidermaltreatment  values 
(cjams.gen_random_uuid(),  '2cfd0126-cf18-4336-9c38-5ac4a74fb096' , 'FCPS', 1, 'CIDM-9195', 'CIDM-9195', now(), now(), now(), null);

---231020817651
INSERT INTO cjams.allegationprovidermaltreatment  values 
(cjams.gen_random_uuid(),  'f9fd836c-7371-4c70-8808-b7b290602a4b' , 'FCPS', 1, 'CIDM-9195', 'CIDM-9195', now(), now(), now(), null);

---211020114154
INSERT INTO cjams.allegationprovidermaltreatment  values 
(cjams.gen_random_uuid(),  'ecb9574e-1dfe-4c16-b6da-7e2387d575a7' , 'FCPS', 1, 'CIDM-9195', 'CIDM-9195', now(), now(), now(), null);

---211020114154
INSERT INTO cjams.allegationprovidermaltreatment  values 
(cjams.gen_random_uuid(),  '9b05fb24-cf70-4cc8-b155-91210474ac73' , 'FCPS', 1, 'CIDM-9195', 'CIDM-9195', now(), now(), now(), null);


---231020404459
INSERT INTO cjams.allegationprovidermaltreatment  values 
(cjams.gen_random_uuid(),  '0c140164-3467-4572-a175-883dab183c71' , 'PP', 1, 'CIDM-9195', 'CIDM-9195', now(), now(), now(), null);

---231020404111
INSERT INTO cjams.allegationprovidermaltreatment  values 
(cjams.gen_random_uuid(),  'd43ebc14-3f5e-400a-9e26-25ed73fbb936' , 'PP', 1, 'CIDM-9195', 'CIDM-9195', now(), now(), now(), null);
