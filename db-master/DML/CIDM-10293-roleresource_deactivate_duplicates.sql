--  Role id 5252
UPDATE cjams.role_resource
SET activeflag=0, updatedby='CIDM-10293', updatedon=now()
WHERE roleid=5252 and id in ('757c6be9-d141-474a-82c4-b36c5dfb43fe') and activeflag = 1;
-- Role id 2452
UPDATE cjams.role_resource
SET activeflag=0, updatedby='CIDM-10293', updatedon=now()
WHERE roleid=2452 and id in ('d5c56a2a-60ff-4ea5-9d1f-f34a7214548b') and activeflag = 1;
-- Role id 3512
UPDATE cjams.role_resource
SET activeflag=0, updatedby='CIDM-10293', updatedon=now()
WHERE roleid=3512 and id in ('689c3229-e45f-4325-9aa3-43105190bb13','0fb3f0ad-f0ca-4acc-9e74-56e325e7e781','c81d4700-19cc-4613-aeea-e99e391aa274') and activeflag = 1;
-- Role id 128
UPDATE cjams.role_resource
SET activeflag=0, updatedby='CIDM-10293', updatedon=now()
WHERE roleid=128 and id in ('dfaed08d-f36a-4b6c-b348-ceea744a14ce','f69c16d6-405c-4b07-993a-d341a0b3c091','1575e4b0-5cfd-4c19-93f0-d321c8975da4',
'0c149a15-01d4-47a2-8220-f080789a2b24','c6d085f5-194d-4eee-a852-38e6ad30d5ef','918f8f94-d564-417d-8d02-86dd8277245e','aef4597a-8592-4199-b88f-203afa2a4722',
'c3dd1c4d-5cdf-4591-9568-212134c14c20','ddf854d9-cb55-4f21-8deb-a08979da4ba7','252f419f-2604-466a-9496-7f3e7be8f0d7','b77b799a-cc11-4da3-90e3-d116e7693393',
'7b9c2257-30b7-43f9-90cf-6c41e158bc65','f6cc0098-d1b2-4ce6-81c3-6c721ae80df0','e416afac-3ad7-4ab4-a570-22d7a736d1ed','66c6a960-40d1-4a3c-a17f-7b159b4251c5',
'348e6661-2f72-4dba-85dc-6f7df3f10d6d','08b87b73-7349-47f5-a917-1a27e8af2ac1','de922d35-3ca8-452c-9305-55975cf3acb9','9a98b77f-3697-44ce-8a61-88cd57bac597',
'f21f1362-68eb-46f7-8fc4-fa35540ca271','d5b6a787-c6cb-4808-8dab-497d19d1f0d8','c26a4cbc-0811-4c7f-9935-37cb1a96aa29','848c1c1f-a402-43fa-97b0-0bf5220defe4',
'22188242-fca2-44bb-bd52-8f964d4fb191','b0c7c11d-8999-4233-9642-b74413e34f1f','5e8a6888-cb62-494c-8fb0-2da54725f76b','5c60c112-97b1-4149-8f60-d5ecefb69408',
'2f394c28-59af-4dfc-b432-de4707576f63','1d3b6226-37a7-4122-b03f-988891655b13','7066a413-377a-47dd-8871-59b2dd866e91','7a8f0c3f-9cc0-4f24-9ab9-9939b0c3dec6',
'd1232744-f4bc-46af-98a4-755558281fdf') and activeflag = 1;
-- Role id 134,136,138,139,140,141,142,146,147,148,149
UPDATE cjams.role_resource
SET activeflag=0, updatedby='CIDM-10293', updatedon=now()
WHERE roleid in (134,136,138,139,140,141,142,146,147,148,149) and insertedon::date = '2020-08-25' and activeflag = 1;
-- Role id 137
UPDATE cjams.role_resource
SET activeflag=0, updatedby='CIDM-10293', updatedon=now()
WHERE roleid=137 and insertedon::date in ('2020-08-06','2020-08-25') and activeflag = 1; 