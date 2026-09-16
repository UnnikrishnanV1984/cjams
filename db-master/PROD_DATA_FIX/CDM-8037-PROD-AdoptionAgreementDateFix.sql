
update adoptionagreementrevision
set activeflag =0, updatedon =now(), updatedby ='CDM-8037'
where adoptionagreementrevisionid in ('32363c79-60ab-478b-8a8b-e81f957b11f4',
'9d67dcd5-58ec-4e22-a012-20244aad437b',
'dc9f1832-e0f0-4215-bb30-ae43c0d0b270');

update adoptionagreement
set activeflag =0, updatedon =now(), updatedby ='CDM-8037'
where adoptionagreementid in ('e82a3b0a-f5fa-4e56-83c6-2a58931ce23d','60a4dcdf-8c6a-4777-b2f2-5b64fe9ab9cb');