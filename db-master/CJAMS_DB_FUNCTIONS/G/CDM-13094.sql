
update serviceplan set serviceplancandidacy = '{"candidates": [{"id": "200641438", "name": "Naomi  Baxter", "candidacy": "0"}]}',
updatedby = 'CDM-13094',updatedon = now()
where serviceplanid = '6c56310a-0bae-4b3d-ad75-dd4a25f57986';


update snapshothist sn
set updatedby ='CDM-13094', updatedon =now(),sn.snapshotdata = jsonb_set(sn.snapshotdata::jsonb, '{serviceplancandidacy}', '{"candidates": [{"id": "200641438", "name": "Naomi  Baxter", "candidacy": "0"}]}')
where sn.id  = '119c4e4c-cbdc-4c11-aa6d-2ae78027ec59' ;