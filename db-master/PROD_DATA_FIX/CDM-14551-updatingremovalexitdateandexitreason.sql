/*
   Issue Description: CDM-14551
   Category/ Module  :  
   Root cause:  updating removal exit reason & exit date
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

--3156433 1478695
UPDATE cjams.intakeservreqchildremoval
SET exitdate='2021-04-09 12:00:00.000', removalexitreason='REUNIF', updatedon=now() , updatedby='CDM-14551'
where intakeservreqchildremovalid = 'a54acd8f-0547-4d23-a57b-62832d116a0e';

-- 2021-03-09 12:00:00
--3156433 1419232
UPDATE cjams.intakeservreqchildremoval
SET exitdate='2021-04-09 12:00:00.000', removalexitreason='REUNIF', updatedon=now() , updatedby='CDM-14551'
where intakeservreqchildremovalid = 'a54acd8f-0547-4d23-a57b-62832d116a0e';

-- 2021-05-31 00:00:00 
update personprogramarea set enddate = '2021-05-31 00:00:00', updatedon=now() , updatedby='CDM-14551'
where personprogramid = 'f0e2ff75-ecf0-418f-b7d1-50e6a392b84e';


--2020021002033 4237196
UPDATE cjams.intakeservreqchildremoval
SET exitdate='2021-04-22 00:00:00.000', removalexitreason='REUNIF', updatedon=now() , updatedby='CDM-14551'
where intakeservreqchildremovalid = '4b2935ff-6699-4dac-8953-95c5d316736f';

-- 2021-05-04 18:54:03
update personprogramarea set enddate = '2021-04-22 18:54:03', updatedon=now() , updatedby='CDM-14551'
where personprogramid = '6f752a3c-73c7-4146-871c-86234bf72d73';

-- 3305337 4457196
UPDATE cjams.intakeservreqchildremoval
SET exitdate='2021-04-22 00:00:00.000', removalexitreason='REUNIF', updatedon=now() , updatedby='CDM-14551'
where intakeservreqchildremovalid = 'fc0d791c-1c23-45a1-8ab6-9aa5d083b960';

-- 2021-05-10 12:25:30
update personprogramarea set enddate = '2021-04-22 12:25:30', updatedon=now() , updatedby='CDM-14551'
where personprogramid = '7bb9f115-dfc6-4433-af6f-305308095be2';

-- 3254891 3775946 CORHADR
UPDATE cjams.intakeservreqchildremoval
SET exitdate='2021-01-22 00:00:00', removalexitreason='REUNIF', updatedon=now() , updatedby='CDM-14551'
where intakeservreqchildremovalid = '9ed3862c-a34a-4a85-8806-a5d5d037ddd1';

-- 2021-01-28 16:13:29
update personprogramarea set enddate = '2021-01-22 16:13:29', updatedon=now() , updatedby='CDM-14551'
where personprogramid = 'a27d04b4-74ae-4d6a-b11b-ef8493b635f8';



-- 3240900 3677528
--UPDATE cjams.intakeservreqchildremoval
--SET exitdate='2020-11-10 17:00:00', removalexitreason='CGUARDREL', updatedon=now() , updatedby='CDM-14551'
--where intakeservreqchildremovalid = '3188fe6d-2580-4838-be09-6f96eda93b3c';

--3296994 4337683
-- 2020-11-10 17:00:00	CGUARDREL
UPDATE cjams.intakeservreqchildremoval
SET exitdate='2021-01-26 00:00:00', removalexitreason='ADPFIN', updatedon=now() , updatedby='CDM-14551'
where intakeservreqchildremovalid = '130c1a0d-644c-4366-8544-e301d125990a';

-- 3290769 4298250
UPDATE cjams.intakeservreqchildremoval
SET exitdate='2020-06-09 00:00:00', removalexitreason='CGUARDREL', updatedon=now() , updatedby='CDM-14551'
where intakeservreqchildremovalid = '98946147-9013-4a28-bd6d-a8c2db572e35';


update personprogramarea set enddate = '2020-06-09 00:00:00', updatedon=now() , updatedby='CDM-14551'
where personprogramid = '27305957-5bc5-4cc3-8afe-3929d1cb8760';


-- 3290769 4298248
UPDATE cjams.intakeservreqchildremoval
SET exitdate='2020-06-09 00:00:00', removalexitreason='CGUARDREL', updatedon=now() , updatedby='CDM-14551'
where intakeservreqchildremovalid = '5f73d08f-c424-4de9-b1db-f46892e05379';

update personprogramarea set enddate = '2020-06-09 00:00:00', updatedon=now() , updatedby='CDM-14551'
where personprogramid = '393ccbdb-90cd-4050-aa17-9c16fcc2b8f0';

-- 3305868 4473585
UPDATE cjams.intakeservreqchildremoval
SET exitdate = '2021-06-01 00:00:00', removalexitreason='REUNIF', updatedon=now() , updatedby='CDM-14551'
where intakeservreqchildremovalid= '73f8fbbb-ebd3-476f-af82-fce9f17120c4';

-- 2021-06-22 12:39:22
update personprogramarea set enddate = '2020-06-01 00:00:00', updatedon=now() , updatedby='CDM-14551'
where personprogramid = 'd6da9d14-03a1-42bf-a302-0cffc19d4745';
