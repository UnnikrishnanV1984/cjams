/*
    Issue no : CDM-16514
    Issue desc : User asked to update the end date for living arrangement placement
*/

update livingarrangement 
set livingenddate = '2021-06-04 00:00:00', updatedon = now(), updatedby = 'CDM-16514' 
where placementid in ('81f4210b-23b0-4908-bb37-ee3566db06d6', '600f7b45-e7bc-43b7-be09-9f4c9fec7845');

update placement 
set enddatetime = '2021-06-04 00:00:00', updatedon = now(), updatedby = 'CDM-16514' 
where placementid in ('81f4210b-23b0-4908-bb37-ee3566db06d6', '600f7b45-e7bc-43b7-be09-9f4c9fec7845');