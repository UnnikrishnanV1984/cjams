

/*
   Issue Description: CDM-28519
   Category/ Module  :Person Module
   Pull request# for code fix: Remove duplicate person 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update cjams.intakeservicerequestactor 
set activeflag = 0, updatedby = 'CDM-28519', updatedon = now()
where intakeservicerequestactorid in('b42980fd-2e1b-4627-ab0f-277c7dba84ee','d102de16-a4cb-4827-b533-3a60b2d29ec8','7e8b5a5b-54cf-4919-90c1-383a08f13ce8') and personid = 'c9b83836-2a99-4c61-b606-b2b7bb3c50f3';



update cjams.intakeservicerequestactor 
set activeflag = 0, updatedby = 'CDM-28519', updatedon = now()
where intakeservicerequestactorid in('86c1e98c-6fc7-41cf-a1c0-4f20a9fed237','f876f71c-92fe-4cfe-9834-a7842bda888d') and personid = '3b61c782-b5e1-413f-8e88-73b6641c8d35';


update cjams.intakeservicerequestactor 
set activeflag = 0, updatedby = 'CDM-28519', updatedon = now()
where intakeservicerequestactorid in('8e5c2861-7902-4476-bace-0eb6dbf08aaf') and personid = 'd3e045c8-9ddb-41dc-8e5b-eec18e70d9fe';


update cjams.intakeservicerequestactor 
set activeflag = 0, updatedby = 'CDM-28519', updatedon = now()
where intakeservicerequestactorid in('021c10dc-b954-40eb-8364-c85ad2514050') and personid = '3948939c-2f3d-41e8-9e4f-e0f911a8358e';

update cjams.intakeservicerequestactor 
set activeflag = 0, updatedby = 'CDM-28519', updatedon = now()
where intakeservicerequestactorid in('7f6bc3d5-0756-4050-9f50-7a048b0c7d4e') and personid = '780bcf81-4c7b-4917-ba28-126733058ed0';



update actor set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-28519'
where actorid = '2b0bb24c-e8ea-4f58-86ca-147d7b5a9f23';

update actor set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-28519'
where actorid = 'eb584735-24ec-4b39-b722-cbf81e756ffa';

update actor set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-28519'
where actorid = '94784126-b8a2-4f33-aabe-72f5b9e27b93';

update actor set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-28519'
where actorid = '81f8d8c3-47b5-4aa7-8e79-758ed5d76cb5';

update actor set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-28519'
where actorid = '75f0b009-91d3-448b-b2c4-c492055849de';

--removed one more record as per QA request 

update cjams.intakeservicerequestactor 
set activeflag = 1, updatedby = 'CDM-28519', updatedon = now()
where intakeservicerequestactorid in('a65c3e3a-15bb-4a1d-ba19-0887b41c6398','02a613d7-dffd-4e89-a25b-af8ce25e9417') and personid = 'f1e15dbe-ddcd-4e64-94a3-367ab79f7900';

update actor set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-28519'
where actorid = '07ef3df4-5466-4a49-93d6-ed11533982cd';