/*
   Issue Description: CDM-22999
   Category/ Module  : Service Plan
   Root cause: Snapshothist.snapshotdata.serviceplancandidacy is being used for candidacys to display the names. But this field is null. 

   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/


update serviceplan set serviceplancandidacy = '{"candidates": [{"id": "3027179", "name": "JACOB KING", "candidacy": "1"}]}',
updatedby = 'CDM-22999',updatedon = now()
where serviceplanid = '625e3bcf-db8a-4319-bafe-983950884323';


update snapshothist sn
set updatedby ='CDM-22999', updatedon =now(),sn.snapshotdata = jsonb_set(sn.snapshotdata::jsonb, '{serviceplancandidacy}', '{"candidates": [{"id": "3027179", "name": "JACOB KING", "candidacy": "1"}]}')
where sn.id  = '97d9d9e4-f8db-47c1-9afa-d6abd26f347c' ;
