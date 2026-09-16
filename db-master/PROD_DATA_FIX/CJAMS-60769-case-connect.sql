/*
Issue:Dashboard:Please disconnect 251023091141 from 251030537699. Please connect 251023091141 to 251030537699.
Root Cause:User request deactive unecssary record,activare required record into CPS-IR case because of user can able to crate they do not access to do that.
Fix Provided (Data Fix Only):Data fix was done by Updated actor with ralted tabbles.
Data/Code fix ticket#: CJAMS-60769
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: The issue was casused by incorrect service , not a problem in the apllication code, so only a data update was needed to correct it.
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
delete from actor where updatedby='CJAMS-60769' ;
delete from intakeservicerequestactor where updatedby='CJAMS-60769' ;
delete from actorrelationship where updatedby='CJAMS-60769' ;
delete from personrole where updatedby='CJAMS-60769' ;
*/


update intakeservicerequest
set servicecaseid ='86250053-849d-492e-b5ef-c0829568f141',updatedby='CJAMS-60769',updatedon = now()
where intakeserviceid = '29d7c031-4da5-4808-b9d1-61e76ba4d031' and activeflag=1;

insert into actor
(actorid,activeflag,personid,actortype,insertedby,insertedon,updatedby,updatedon,servicecaseid,intakeserviceid,intakenumber,personroletypeid)
values
(gen_random_uuid(), '1','d77b8249-4149-4a9a-a610-aef8b99186a5','CHILD',    'CJAMS-60769',now(),'CJAMS-60769',now(),'86250053-849d-492e-b5ef-c0829568f141' ,'29d7c031-4da5-4808-b9d1-61e76ba4d031','I251013321723','307df447-5bd6-48e6-90ee-c3cdc293f674'),
(gen_random_uuid(), '1','94351ccb-cebf-49a7-8682-9b4ded4d0475','CHILD',    'CJAMS-60769',now(),'CJAMS-60769',now(),'86250053-849d-492e-b5ef-c0829568f141' ,'29d7c031-4da5-4808-b9d1-61e76ba4d031','I251013321723','48641871-17ec-4363-b4f4-2d18c5e55a9c'),
(gen_random_uuid(), '1','15c490e0-0489-46a8-bb99-3b1b2c5ba58c','PARENT',   'CJAMS-60769',now(),'CJAMS-60769',now(),'86250053-849d-492e-b5ef-c0829568f141' ,'29d7c031-4da5-4808-b9d1-61e76ba4d031','I251013321723','a1d3036b-68c2-45a5-b74f-b4358c845349'),
(gen_random_uuid(), '1','7983aa2c-5847-4e0a-89c0-c2808c69789a','CHILD',    'CJAMS-60769',now(),'CJAMS-60769',now(),'86250053-849d-492e-b5ef-c0829568f141' ,'29d7c031-4da5-4808-b9d1-61e76ba4d031','I251013321723','3cfcccf2-ff16-409d-bf9b-f7ca6f7c5ca4'),
(gen_random_uuid(), '1','f2ebdc1c-d94a-436f-8c9d-e911c3efb0e3','PARENT',   'CJAMS-60769',now(),'CJAMS-60769',now(),'86250053-849d-492e-b5ef-c0829568f141' ,'29d7c031-4da5-4808-b9d1-61e76ba4d031','I251013321723','7d18f61b-2710-40db-a111-049a58c5e560'),
(gen_random_uuid(), '1','9e3cc8c7-2f25-4452-a3c8-23be623d6e86','CHILD',    'CJAMS-60769',now(),'CJAMS-60769',now(),'86250053-849d-492e-b5ef-c0829568f141' ,'29d7c031-4da5-4808-b9d1-61e76ba4d031','I251013321723','27ef151c-7873-409a-8503-305549c648d1'),
(gen_random_uuid(), '1','c2ed18e5-b76a-4ebb-aa1d-c279b6a53bc6','CHILD',    'CJAMS-60769',now(),'CJAMS-60769',now(),'86250053-849d-492e-b5ef-c0829568f141' ,'29d7c031-4da5-4808-b9d1-61e76ba4d031','I251013321723','596f861c-75c4-4a2d-b063-a5ac2611c5e5');



insert into intakeservicerequestactor
(intakeservicerequestactorid,activeflag,actorid,personid,intakeservicerequestpersontypekey,insertedby,insertedon,updatedby,updatedon,	servicecaseid,intakeserviceid,intakenumber)
values
(gen_random_uuid(), '1','8ed4890b-238a-4ba0-b549-d520db3924b5','f2ebdc1c-d94a-436f-8c9d-e911c3efb0e3','PARENT',  'CJAMS-60769',now(),'CJAMS-60769',now(),'86250053-849d-492e-b5ef-c0829568f141' ,'29d7c031-4da5-4808-b9d1-61e76ba4d031','I251013321723'),
(gen_random_uuid(), '1','328251f9-162e-409b-ac87-9fe7757e3ceb','d77b8249-4149-4a9a-a610-aef8b99186a5','CHILD',   'CJAMS-60769',now(),'CJAMS-60769',now(),'86250053-849d-492e-b5ef-c0829568f141' ,'29d7c031-4da5-4808-b9d1-61e76ba4d031','I251013321723'),
(gen_random_uuid(), '1','e9db48a3-3bfc-4024-bd34-57cb1cbdbb9d','c2ed18e5-b76a-4ebb-aa1d-c279b6a53bc6','CHILD',   'CJAMS-60769',now(),'CJAMS-60769',now(),'86250053-849d-492e-b5ef-c0829568f141' ,'29d7c031-4da5-4808-b9d1-61e76ba4d031','I251013321723'),
(gen_random_uuid(), '1','6da2e97d-b4e9-4d54-ae55-6f0123b0a416','15c490e0-0489-46a8-bb99-3b1b2c5ba58c','PARENT',  'CJAMS-60769',now(),'CJAMS-60769',now(),'86250053-849d-492e-b5ef-c0829568f141' ,'29d7c031-4da5-4808-b9d1-61e76ba4d031','I251013321723'),
(gen_random_uuid(), '1','6da2e97d-b4e9-4d54-ae55-6f0123b0a416','15c490e0-0489-46a8-bb99-3b1b2c5ba58c','ICC',     'CJAMS-60769',now(),'CJAMS-60769',now(),'86250053-849d-492e-b5ef-c0829568f141' ,'29d7c031-4da5-4808-b9d1-61e76ba4d031','I251013321723'),
(gen_random_uuid(), '1','3de54207-074e-4ad8-bc31-60cfa27e668e','94351ccb-cebf-49a7-8682-9b4ded4d0475','CHILD',   'CJAMS-60769',now(),'CJAMS-60769',now(),'86250053-849d-492e-b5ef-c0829568f141' ,'29d7c031-4da5-4808-b9d1-61e76ba4d031','I251013321723'),
(gen_random_uuid(), '1','d13738b7-61d5-4923-bad8-d8091000a148','9e3cc8c7-2f25-4452-a3c8-23be623d6e86','CHILD',   'CJAMS-60769',now(),'CJAMS-60769',now(),'86250053-849d-492e-b5ef-c0829568f141' ,'29d7c031-4da5-4808-b9d1-61e76ba4d031','I251013321723'),
(gen_random_uuid(), '1','7d3f5c17-5c4e-4664-8f4b-b48f56769729','7983aa2c-5847-4e0a-89c0-c2808c69789a','CHILD',   'CJAMS-60769',now(),'CJAMS-60769',now(),'86250053-849d-492e-b5ef-c0829568f141' ,'29d7c031-4da5-4808-b9d1-61e76ba4d031','I251013321723');




insert into actorrelationship
(actorrelationshipid,activeflag,intakeservicerequestactorid,relationshiptypekey,person1id,person2id,servicecaseid,intakeserviceid,intakenumber,updatedby,updatedon,insertedby,insertedon)
values
(gen_random_uuid(),'1','18b37f8b-97a8-4179-aa07-4c9d85b2caf7','BGMTHR',  '15c490e0-0489-46a8-bb99-3b1b2c5ba58c','7983aa2c-5847-4e0a-89c0-c2808c69789a','86250053-849d-492e-b5ef-c0829568f141','29d7c031-4da5-4808-b9d1-61e76ba4d031','I251013321723','CJAMS-60769',now(),'CJAMS-60769',now()),
(gen_random_uuid(),'1','574d5a8b-3591-44ab-8cdc-2cc6d92c94be','BGCHLD',  '7983aa2c-5847-4e0a-89c0-c2808c69789a','15c490e0-0489-46a8-bb99-3b1b2c5ba58c','86250053-849d-492e-b5ef-c0829568f141','29d7c031-4da5-4808-b9d1-61e76ba4d031','I251013321723','CJAMS-60769',now(),'CJAMS-60769',now()),
(gen_random_uuid(),'1','574d5a8b-3591-44ab-8cdc-2cc6d92c94be','BGSISTR', '7983aa2c-5847-4e0a-89c0-c2808c69789a','94351ccb-cebf-49a7-8682-9b4ded4d0475','86250053-849d-492e-b5ef-c0829568f141','29d7c031-4da5-4808-b9d1-61e76ba4d031','I251013321723','CJAMS-60769',now(),'CJAMS-60769',now()),
(gen_random_uuid(),'1','574d5a8b-3591-44ab-8cdc-2cc6d92c94be','BGSISTR', '7983aa2c-5847-4e0a-89c0-c2808c69789a','9e3cc8c7-2f25-4452-a3c8-23be623d6e86','86250053-849d-492e-b5ef-c0829568f141','29d7c031-4da5-4808-b9d1-61e76ba4d031','I251013321723','CJAMS-60769',now(),'CJAMS-60769',now()),
(gen_random_uuid(),'1','574d5a8b-3591-44ab-8cdc-2cc6d92c94be','BGSISTR', '7983aa2c-5847-4e0a-89c0-c2808c69789a','d77b8249-4149-4a9a-a610-aef8b99186a5','86250053-849d-492e-b5ef-c0829568f141','29d7c031-4da5-4808-b9d1-61e76ba4d031','I251013321723','CJAMS-60769',now(),'CJAMS-60769',now()),
(gen_random_uuid(),'1','574d5a8b-3591-44ab-8cdc-2cc6d92c94be','BGSISTR', '7983aa2c-5847-4e0a-89c0-c2808c69789a','c2ed18e5-b76a-4ebb-aa1d-c279b6a53bc6','86250053-849d-492e-b5ef-c0829568f141','29d7c031-4da5-4808-b9d1-61e76ba4d031','I251013321723','CJAMS-60769',now(),'CJAMS-60769',now()),
(gen_random_uuid(),'1','574d5a8b-3591-44ab-8cdc-2cc6d92c94be','BGCHLD',  '7983aa2c-5847-4e0a-89c0-c2808c69789a','f2ebdc1c-d94a-436f-8c9d-e911c3efb0e3','86250053-849d-492e-b5ef-c0829568f141','29d7c031-4da5-4808-b9d1-61e76ba4d031','I251013321723','CJAMS-60769',now(),'CJAMS-60769',now()),
(gen_random_uuid(),'1','7cc7cf7b-d281-4094-ac24-1c6a060a7147','BIOBR ',  '9e3cc8c7-2f25-4452-a3c8-23be623d6e86','7983aa2c-5847-4e0a-89c0-c2808c69789a','86250053-849d-492e-b5ef-c0829568f141','29d7c031-4da5-4808-b9d1-61e76ba4d031','I251013321723','CJAMS-60769',now(),'CJAMS-60769',now()),
(gen_random_uuid(),'1','7cc7cf7b-d281-4094-ac24-1c6a060a7147','BIOBR ',  '9e3cc8c7-2f25-4452-a3c8-23be623d6e86','94351ccb-cebf-49a7-8682-9b4ded4d0475','86250053-849d-492e-b5ef-c0829568f141','29d7c031-4da5-4808-b9d1-61e76ba4d031','I251013321723','CJAMS-60769',now(),'CJAMS-60769',now()),
(gen_random_uuid(),'1','7cc7cf7b-d281-4094-ac24-1c6a060a7147','BIOBR ',  '9e3cc8c7-2f25-4452-a3c8-23be623d6e86','c2ed18e5-b76a-4ebb-aa1d-c279b6a53bc6','86250053-849d-492e-b5ef-c0829568f141','29d7c031-4da5-4808-b9d1-61e76ba4d031','I251013321723','CJAMS-60769',now(),'CJAMS-60769',now()),
(gen_random_uuid(),'1','7cc7cf7b-d281-4094-ac24-1c6a060a7147','BIOBR ',  '9e3cc8c7-2f25-4452-a3c8-23be623d6e86','d77b8249-4149-4a9a-a610-aef8b99186a5','86250053-849d-492e-b5ef-c0829568f141','29d7c031-4da5-4808-b9d1-61e76ba4d031','I251013321723','CJAMS-60769',now(),'CJAMS-60769',now()),
(gen_random_uuid(),'1','7cc7cf7b-d281-4094-ac24-1c6a060a7147','BGCHLD',  '9e3cc8c7-2f25-4452-a3c8-23be623d6e86','f2ebdc1c-d94a-436f-8c9d-e911c3efb0e3','86250053-849d-492e-b5ef-c0829568f141','29d7c031-4da5-4808-b9d1-61e76ba4d031','I251013321723','CJAMS-60769',now(),'CJAMS-60769',now()),
(gen_random_uuid(),'1','eeb04aa5-9921-4940-877e-40f34dc5a931','BGSISTR', 'c2ed18e5-b76a-4ebb-aa1d-c279b6a53bc6','7983aa2c-5847-4e0a-89c0-c2808c69789a','86250053-849d-492e-b5ef-c0829568f141','29d7c031-4da5-4808-b9d1-61e76ba4d031','I251013321723','CJAMS-60769',now(),'CJAMS-60769',now()),
(gen_random_uuid(),'1','eeb04aa5-9921-4940-877e-40f34dc5a931','BGSISTR', 'c2ed18e5-b76a-4ebb-aa1d-c279b6a53bc6','94351ccb-cebf-49a7-8682-9b4ded4d0475','86250053-849d-492e-b5ef-c0829568f141','29d7c031-4da5-4808-b9d1-61e76ba4d031','I251013321723','CJAMS-60769',now(),'CJAMS-60769',now()),
(gen_random_uuid(),'1','eeb04aa5-9921-4940-877e-40f34dc5a931','BGSISTR', 'c2ed18e5-b76a-4ebb-aa1d-c279b6a53bc6','9e3cc8c7-2f25-4452-a3c8-23be623d6e86','86250053-849d-492e-b5ef-c0829568f141','29d7c031-4da5-4808-b9d1-61e76ba4d031','I251013321723','CJAMS-60769',now(),'CJAMS-60769',now()),
(gen_random_uuid(),'1','30a6f15e-a5fd-4e95-96ed-fa4b666ed589','BIOBR ',  'd77b8249-4149-4a9a-a610-aef8b99186a5','7983aa2c-5847-4e0a-89c0-c2808c69789a','86250053-849d-492e-b5ef-c0829568f141','29d7c031-4da5-4808-b9d1-61e76ba4d031','I251013321723','CJAMS-60769',now(),'CJAMS-60769',now()),
(gen_random_uuid(),'1','30a6f15e-a5fd-4e95-96ed-fa4b666ed589','BIOBR ',  'd77b8249-4149-4a9a-a610-aef8b99186a5','94351ccb-cebf-49a7-8682-9b4ded4d0475','86250053-849d-492e-b5ef-c0829568f141','29d7c031-4da5-4808-b9d1-61e76ba4d031','I251013321723','CJAMS-60769',now(),'CJAMS-60769',now()),
(gen_random_uuid(),'1','30a6f15e-a5fd-4e95-96ed-fa4b666ed589','BIOBR ',  'd77b8249-4149-4a9a-a610-aef8b99186a5','9e3cc8c7-2f25-4452-a3c8-23be623d6e86','86250053-849d-492e-b5ef-c0829568f141','29d7c031-4da5-4808-b9d1-61e76ba4d031','I251013321723','CJAMS-60769',now(),'CJAMS-60769',now()),
(gen_random_uuid(),'1','804f8559-0f07-44f5-a174-a574dbe086fd','BGFTHR',  'f2ebdc1c-d94a-436f-8c9d-e911c3efb0e3','7983aa2c-5847-4e0a-89c0-c2808c69789a','86250053-849d-492e-b5ef-c0829568f141','29d7c031-4da5-4808-b9d1-61e76ba4d031','I251013321723','CJAMS-60769',now(),'CJAMS-60769',now()),
(gen_random_uuid(),'1','804f8559-0f07-44f5-a174-a574dbe086fd','BGFTHR',  'f2ebdc1c-d94a-436f-8c9d-e911c3efb0e3','94351ccb-cebf-49a7-8682-9b4ded4d0475','86250053-849d-492e-b5ef-c0829568f141','29d7c031-4da5-4808-b9d1-61e76ba4d031','I251013321723','CJAMS-60769',now(),'CJAMS-60769',now()),
(gen_random_uuid(),'1','804f8559-0f07-44f5-a174-a574dbe086fd','BGFTHR',  'f2ebdc1c-d94a-436f-8c9d-e911c3efb0e3','9e3cc8c7-2f25-4452-a3c8-23be623d6e86','86250053-849d-492e-b5ef-c0829568f141','29d7c031-4da5-4808-b9d1-61e76ba4d031','I251013321723','CJAMS-60769',now(),'CJAMS-60769',now()),
(gen_random_uuid(),'1','07ef7870-2f63-497d-bd30-8ba54d7a1fb4','BIOBR ',  '94351ccb-cebf-49a7-8682-9b4ded4d0475','7983aa2c-5847-4e0a-89c0-c2808c69789a','86250053-849d-492e-b5ef-c0829568f141','29d7c031-4da5-4808-b9d1-61e76ba4d031','I251013321723','CJAMS-60769',now(),'CJAMS-60769',now()),
(gen_random_uuid(),'1','07ef7870-2f63-497d-bd30-8ba54d7a1fb4','BIOBR ',  '94351ccb-cebf-49a7-8682-9b4ded4d0475','9e3cc8c7-2f25-4452-a3c8-23be623d6e86','86250053-849d-492e-b5ef-c0829568f141','29d7c031-4da5-4808-b9d1-61e76ba4d031','I251013321723','CJAMS-60769',now(),'CJAMS-60769',now()),
(gen_random_uuid(),'1','07ef7870-2f63-497d-bd30-8ba54d7a1fb4','BGCHLD',  '94351ccb-cebf-49a7-8682-9b4ded4d0475','f2ebdc1c-d94a-436f-8c9d-e911c3efb0e3','86250053-849d-492e-b5ef-c0829568f141','29d7c031-4da5-4808-b9d1-61e76ba4d031','I251013321723','CJAMS-60769',now(),'CJAMS-60769',now()),
(gen_random_uuid(),'1','07ef7870-2f63-497d-bd30-8ba54d7a1fb4','BIOBR ',  '94351ccb-cebf-49a7-8682-9b4ded4d0475','d77b8249-4149-4a9a-a610-aef8b99186a5','86250053-849d-492e-b5ef-c0829568f141','29d7c031-4da5-4808-b9d1-61e76ba4d031','I251013321723','CJAMS-60769',now(),'CJAMS-60769',now()),
(gen_random_uuid(),'1','07ef7870-2f63-497d-bd30-8ba54d7a1fb4','BIOBR ',  '94351ccb-cebf-49a7-8682-9b4ded4d0475','c2ed18e5-b76a-4ebb-aa1d-c279b6a53bc6','86250053-849d-492e-b5ef-c0829568f141','29d7c031-4da5-4808-b9d1-61e76ba4d031','I251013321723','CJAMS-60769',now(),'CJAMS-60769',now()),
(gen_random_uuid(),'1','7cc7cf7b-d281-4094-ac24-1c6a060a7147','BGCHLD',  '9e3cc8c7-2f25-4452-a3c8-23be623d6e86','15c490e0-0489-46a8-bb99-3b1b2c5ba58c','86250053-849d-492e-b5ef-c0829568f141','29d7c031-4da5-4808-b9d1-61e76ba4d031','I251013321723','CJAMS-60769',now(),'CJAMS-60769',now()),
(gen_random_uuid(),'1','07ef7870-2f63-497d-bd30-8ba54d7a1fb4','BGCHLD',  '94351ccb-cebf-49a7-8682-9b4ded4d0475','15c490e0-0489-46a8-bb99-3b1b2c5ba58c','86250053-849d-492e-b5ef-c0829568f141','29d7c031-4da5-4808-b9d1-61e76ba4d031','I251013321723','CJAMS-60769',now(),'CJAMS-60769',now()),
(gen_random_uuid(),'1','30a6f15e-a5fd-4e95-96ed-fa4b666ed589','BIOBR ',  'd77b8249-4149-4a9a-a610-aef8b99186a5','c2ed18e5-b76a-4ebb-aa1d-c279b6a53bc6','86250053-849d-492e-b5ef-c0829568f141','29d7c031-4da5-4808-b9d1-61e76ba4d031','I251013321723','CJAMS-60769',now(),'CJAMS-60769',now()),
(gen_random_uuid(),'1','eeb04aa5-9921-4940-877e-40f34dc5a931','BGSISTR', 'c2ed18e5-b76a-4ebb-aa1d-c279b6a53bc6','d77b8249-4149-4a9a-a610-aef8b99186a5','86250053-849d-492e-b5ef-c0829568f141','29d7c031-4da5-4808-b9d1-61e76ba4d031','I251013321723','CJAMS-60769',now(),'CJAMS-60769',now()),
(gen_random_uuid(),'1','18b37f8b-97a8-4179-aa07-4c9d85b2caf7','BGMTHR',  '15c490e0-0489-46a8-bb99-3b1b2c5ba58c','c2ed18e5-b76a-4ebb-aa1d-c279b6a53bc6','86250053-849d-492e-b5ef-c0829568f141','29d7c031-4da5-4808-b9d1-61e76ba4d031','I251013321723','CJAMS-60769',now(),'CJAMS-60769',now()),
(gen_random_uuid(),'1','30a6f15e-a5fd-4e95-96ed-fa4b666ed589','BGCHLD',  'd77b8249-4149-4a9a-a610-aef8b99186a5','15c490e0-0489-46a8-bb99-3b1b2c5ba58c','86250053-849d-492e-b5ef-c0829568f141','29d7c031-4da5-4808-b9d1-61e76ba4d031','I251013321723','CJAMS-60769',now(),'CJAMS-60769',now()),
(gen_random_uuid(),'1','eeb04aa5-9921-4940-877e-40f34dc5a931','BGCHLD',  'c2ed18e5-b76a-4ebb-aa1d-c279b6a53bc6','15c490e0-0489-46a8-bb99-3b1b2c5ba58c','86250053-849d-492e-b5ef-c0829568f141','29d7c031-4da5-4808-b9d1-61e76ba4d031','I251013321723','CJAMS-60769',now(),'CJAMS-60769',now()),
(gen_random_uuid(),'1','18b37f8b-97a8-4179-aa07-4c9d85b2caf7','BGMTHR',  '15c490e0-0489-46a8-bb99-3b1b2c5ba58c','d77b8249-4149-4a9a-a610-aef8b99186a5','86250053-849d-492e-b5ef-c0829568f141','29d7c031-4da5-4808-b9d1-61e76ba4d031','I251013321723','CJAMS-60769',now(),'CJAMS-60769',now()),
(gen_random_uuid(),'1','18b37f8b-97a8-4179-aa07-4c9d85b2caf7','BGMTHR',  '15c490e0-0489-46a8-bb99-3b1b2c5ba58c','9e3cc8c7-2f25-4452-a3c8-23be623d6e86','86250053-849d-492e-b5ef-c0829568f141','29d7c031-4da5-4808-b9d1-61e76ba4d031','I251013321723','CJAMS-60769',now(),'CJAMS-60769',now()),
(gen_random_uuid(),'1','18b37f8b-97a8-4179-aa07-4c9d85b2caf7','BGMTHR',  '15c490e0-0489-46a8-bb99-3b1b2c5ba58c','94351ccb-cebf-49a7-8682-9b4ded4d0475','86250053-849d-492e-b5ef-c0829568f141','29d7c031-4da5-4808-b9d1-61e76ba4d031','I251013321723','CJAMS-60769',now(),'CJAMS-60769',now());


insert into personrole
(personroleid,activeflag,personid,insertedby,insertedon,updatedby,updatedon,intakeserviceid,intakenumber,servicecaseid)
values
(gen_random_uuid(),'1','f2ebdc1c-d94a-436f-8c9d-e911c3efb0e3','CJAMS-60769',now(),'CJAMS-60769',now(),'29d7c031-4da5-4808-b9d1-61e76ba4d031','I251013321723','86250053-849d-492e-b5ef-c0829568f141'),
(gen_random_uuid(),'1','15c490e0-0489-46a8-bb99-3b1b2c5ba58c','CJAMS-60769',now(),'CJAMS-60769',now(),'29d7c031-4da5-4808-b9d1-61e76ba4d031','I251013321723','86250053-849d-492e-b5ef-c0829568f141'),
(gen_random_uuid(),'1','c2ed18e5-b76a-4ebb-aa1d-c279b6a53bc6','CJAMS-60769',now(),'CJAMS-60769',now(),'29d7c031-4da5-4808-b9d1-61e76ba4d031','I251013321723','86250053-849d-492e-b5ef-c0829568f141'),
(gen_random_uuid(),'1','9e3cc8c7-2f25-4452-a3c8-23be623d6e86','CJAMS-60769',now(),'CJAMS-60769',now(),'29d7c031-4da5-4808-b9d1-61e76ba4d031','I251013321723','86250053-849d-492e-b5ef-c0829568f141'),
(gen_random_uuid(),'1','94351ccb-cebf-49a7-8682-9b4ded4d0475','CJAMS-60769',now(),'CJAMS-60769',now(),'29d7c031-4da5-4808-b9d1-61e76ba4d031','I251013321723','86250053-849d-492e-b5ef-c0829568f141'),
(gen_random_uuid(),'1','7983aa2c-5847-4e0a-89c0-c2808c69789a','CJAMS-60769',now(),'CJAMS-60769',now(),'29d7c031-4da5-4808-b9d1-61e76ba4d031','I251013321723','86250053-849d-492e-b5ef-c0829568f141'),
(gen_random_uuid(),'1','d77b8249-4149-4a9a-a610-aef8b99186a5','CJAMS-60769',now(),'CJAMS-60769',now(),'29d7c031-4da5-4808-b9d1-61e76ba4d031','I251013321723','86250053-849d-492e-b5ef-c0829568f141');
