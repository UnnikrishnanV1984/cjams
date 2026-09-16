update servicecase set startdate = '2021-12-09' , 
		effectivedate='2021-12-09 14:49:00.182', updatedby = 'CDM-19495', updatedon = now() 
		where servicecaseid = 'c7a79063-e07d-403c-829e-c149a65d7355';

update servicecasedisposition 
set statusdate = '2021-12-09 14:49:00', effectivedate = '2021-12-09 14:49:00', updatedby = 'CDM-19495', updatedon = now() 
where servicecasedispositionid = 'c5c42dc4-0acb-492b-bb9f-e70501dfd4d3';

update caseassignment 
set startdate = '2021-12-09 14:49:18', assigndate = '2021-12-09 00:00:00', updatedby = 'CDM-19495', updatedon = now() 
where objectid = 'c7a79063-e07d-403c-829e-c149a65d7355';