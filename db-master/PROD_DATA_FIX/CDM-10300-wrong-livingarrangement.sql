update placement
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-10300'
where 
placementid in ('72e8a60d-e363-4de9-94e4-64dad87d30e5', '06a17fbc-1fcc-40df-99c8-be051a7a07af');
