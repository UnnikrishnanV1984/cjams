update documentproperties
set activeflag=0, updatedon = now(), updatedby = 'CDM-12921'
where documentpropertiesid in ('996cdceb-bab2-4440-8fa6-3e228a892718',
'1294ee9d-4ca1-4854-aa19-cfe027b5cfc4',
'1d1707bb-b7c7-46f0-88f1-73e914dabe63',
'1f5b191d-0a45-4010-b795-3df890b5e766',
'77762acc-c25a-42d3-88e1-55a62a710304',
'5ee35de0-59bf-453e-8306-30193fde9175');