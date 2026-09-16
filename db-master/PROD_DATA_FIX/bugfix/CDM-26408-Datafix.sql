/*
   Issue Description: CDM-26408
   Category/ Module  : Prod data fix to change the updatedon 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
update assessment 
set updatedon = insertedon 
where assessmentid in ('e3121832-e91c-48f9-a0b5-bf69fda25215',
'2cb2bcfc-a385-4aa9-bad2-db065262e332',
'0243c1cb-6161-41b9-8757-b1455f100099',
'ca205596-001d-49a2-a696-d9bcd7137763');