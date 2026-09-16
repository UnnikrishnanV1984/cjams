update personidentifier 
set
personidentifiervalue = 'MDT-124314483',
updatedby = 'CDM-12426',
updatedon = now() 
where 
personidentifierid = 'fef6c0ad-ade1-46f2-95d0-7a03596a6ae9';



update personidentifier 
set
personidentifiervalue = 'MDT-138108400',
updatedby = 'CDM-12426',
updatedon = now() 
where 
personidentifierid = 'c263a7f8-7942-4286-bf4e-2bbc27b90248';

update intakeservicerequestactor set 
personid = '2225fd58-88b2-46cf-9163-65b9628ad3dd',
updatedby = 'CDM_12417',
updatedon = now()
where intakeserviceid = 'c7c1895c-7974-4893-9263-06c4e152fe25'
and personid = '0785f3cb-6247-4132-905f-ca9a21713fa3';


update actor set 
personid = '2225fd58-88b2-46cf-9163-65b9628ad3dd',
updatedby = 'CDM_12417',
updatedon = now()
where actorid = 'f9f4de67-1fff-4b18-8ff3-291c449333d2';

update personrole set
personid = '2225fd58-88b2-46cf-9163-65b9628ad3dd',
updatedby = 'CDM_12417',
updatedon = now()
where 
personroleid ='be71e61f-fa51-4e2e-865a-11491d67286c';




update person
set
activeflag = 1,
updatedby = 'CDM-12426',
updatedon = now() 
where
personid = 'cc418323-5907-4273-ae24-fcb293f6b437';

update intakeservicerequestactor set 
personid = 'cc418323-5907-4273-ae24-fcb293f6b437',
updatedby = 'CDM_12417',
updatedon = now()
where servicecaseid in ('c841f240-8d67-47a5-9195-b3f527c3b1df', '7bb127c8-0b0a-480e-8b17-8f5736d5e5a6')
and personid = '0785f3cb-6247-4132-905f-ca9a21713fa3';


update actor set 
personid = 'cc418323-5907-4273-ae24-fcb293f6b437',
updatedby = 'CDM_12417',
updatedon = now()
where actorid in ('20bd9e0b-6874-4a65-a652-f538ed42c312', 'f3412895-1fa7-4961-a549-81bb77683041');

update personrole set
personid = 'cc418323-5907-4273-ae24-fcb293f6b437',
updatedby = 'CDM_12417',
updatedon = now()
where 
personroleid ='73175e37-0805-44d6-a08f-41ba50ec2397';