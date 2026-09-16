update actor set personid = '871df3ab-89cf-4517-be22-eabeb75803d8', updatedby = 'CDM-4653', updatedon = now() where actorid = 'ca34cef2-893e-4af4-bca3-6da12a53df53';

update intakeservicerequestactor set personid = '871df3ab-89cf-4517-be22-eabeb75803d8', updatedby = 'CDM-4653', updatedon = now() where intakeservicerequestactorid in ('6ba4a05b-562a-4c5b-a222-d4e961f6fa55', 'a5248f88-dc62-4644-b88f-3cd491301f29');


update personrole set personid = '871df3ab-89cf-4517-be22-eabeb75803d8', updatedon = now(), updatedby = 'CDM-4653' where personroleid = 'd334a9d5-e206-4f6b-b66c-17f989c2f059';