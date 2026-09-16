/*
   Issue Description: CDM-25206
   Category/ Module  : Update gapdisclosure requestedby
   Root cause: User wants to update the incorrect gapdisclosure requestedby
*/


update gapdisclosure 
set insertedby = 'ceca7825-35d6-41bb-bfc9-df3256d9a1d9',
	updatedby = 'CDM-25206',
	updatedon = now()
where gapdisclosureid = '03c497e5-fb4a-4f24-bc4b-34e440c093e7';

update routing 
set fromsecurityusersid = 'ceca7825-35d6-41bb-bfc9-df3256d9a1d9',
	updatedby = 'CDM-25206',
	updatedon = now()
where routingid = 'f832ea0e-e803-44aa-bb54-ec42125f4f35';

update routing 
set tosecurityusersid = 'ceca7825-35d6-41bb-bfc9-df3256d9a1d9',
	updatedby = 'CDM-25206',
	updatedon = now()
where routingid = '123dbb34-2537-439f-ba4e-a3f56cefa081';