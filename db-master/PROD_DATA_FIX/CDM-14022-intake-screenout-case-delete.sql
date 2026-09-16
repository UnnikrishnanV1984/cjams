UPDATE intakesnapshot 
SET 
updatedby = 'CDM-14022', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber in ('I202100243173', 'I202100343290') AND activeflag=1;

update intakeservicerequest set activeflag = 0, updatedby = 'CDM-14022', updatedon = now() where intakenumber in ('I202100243173', 'I202100343290') or intakeserviceid in ('620e3c89-b1d4-49e4-acc8-a5c9a6390136', 'ded2e75f-af3f-41b8-bd54-cd123002fd0a');

update intakedastaging 
	
	set status = 'Closed', updatedby = 'CDM-14022', updatedon = now()
	
	where intakenumber in ('I202100243173', 'I202100343290')
	and activeflag = 1;
	
update personprogramarea set 
activeflag = 0,
updatedby = 'CDM-14022',
updatedon = now()
where personprogramid in ('69457792-2a1f-4bd4-837b-aba8facc4f43','c45993dc-f06c-4c7d-a946-feb35729cc00',
'4c37b09a-b30b-4757-9733-b62f4e8306c7', 'e97a03b9-f618-45af-ab82-c5bc64e50a12', 'f8671b4d-5171-4d53-9639-ef8a516551ad',
'1aa1c62e-6ea9-4caf-83c1-91cba60a1efe', '9daa1e55-5a53-4bbd-9c11-c68808c7b600', 'f38f821e-a9d8-4ed1-b077-da4cd60c0f29', 
'e97a03b9-f618-45af-ab82-c5bc64e50a12', 'f606928e-8e3a-4ed3-bc24-a3013da0fbbd');

update intakedastatus 
	set status = 8, updatedby = 'CDM-12959', updatedon = now()
	where intakenumber in ('I202100243173', 'I202100343290')
	and activeflag = 1;

update caseassignment
set activeflag = 0, updatedby = 'CDM-14022', updatedon = now() where objectid in ('620e3c89-b1d4-49e4-acc8-a5c9a6390136', 'ded2e75f-af3f-41b8-bd54-cd123002fd0a');
