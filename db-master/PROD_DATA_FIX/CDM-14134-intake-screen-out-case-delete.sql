UPDATE intakesnapshot 
SET 
updatedby = 'CDM-14134', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I202000094113' AND activeflag=1;

update intakeservicerequest set activeflag = 0, updatedby = 'CDM-14134', updatedon = now() where intakenumber = 'I202000094113';

update intakedastaging 
	
	set status = 'Closed', updatedby = 'CDM-14134', updatedon = now()
	
	where intakenumber = 'I202000094113'
	and activeflag = 1;
	
update personprogramarea set 
activeflag = 0,
updatedby = 'CDM-14134',
updatedon = now()
where entityid = '2021025074309';

update caseassignment set 
activeflag = 0,
updatedby = 'CDM-14134',
updatedon = now() where objectid = '41095388-de08-41db-9ca4-4bb4b390ed37';

update intakedastatus 
	set status = 8, updatedby = 'CDM-14134', updatedon = now()
	where intakenumber = 'I202000094113'
	and activeflag = 1;
