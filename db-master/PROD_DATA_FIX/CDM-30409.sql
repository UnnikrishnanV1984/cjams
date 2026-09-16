/*
  Issue Description: CDM-30409
   Category/ Module  :  issues in CJAMS in AACo for FInance when trying to approve Payments.
   Root cause: User role updates
  Fix provided :
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date:  
   Backup before update/ delete:
*/
--
--
--select * from muser where email='janet.adetunji1@maryland.gov'
--select * from cjams.rolemapping where principalid = '15020' and activeflag=1
--select * from cjams.teammemberassignment where securityusersid= 'b8723d80-479b-400b-8e39-6fd94e10ba7e'
--
--
--select * from muser where email='roberta.contee-murray@maryland.gov'
--select * from cjams.rolemapping where principalid = '3394' and activeflag=1
--select * from cjams.teammemberassignment where securityusersid= '5fa4ecd6-9c66-496f-8eff-e32c78192df1'
--
--select * from muser where email='cathleen.barefoot@maryland.gov'
--select * from cjams.rolemapping where principalid = '3950' and activeflag=1
--select * from cjams.teammemberassignment where securityusersid= 'ad6ea6ab-0fe0-4c80-9770-0caaf96962a9'
--
--select * from muser where email='kerry.logue@maryland.gov'
--select * from cjams.rolemapping where principalid = '3936' and activeflag=1
--select * from cjams.teammemberassignment where securityusersid= '1a476bf9-b1b5-4f57-9542-88c9511c3c38'
--
--select * from muser where email='latasha.bradley-mose@maryland.gov'
--select * from cjams.rolemapping where principalid = '3393' and activeflag=1
--select * from cjams.teammemberassignment where securityusersid= '937cf258-7da6-4bdb-8454-c36d8221b19f'


--'janet.adetunji1@maryland.gov'
-- roletypekey is the issue
select * from cjams.teammember where teammemberid='6197a90e-7378-42b7-987e-c17961053da6' and activeflag=1;
update cjams.teammember set roletypekey='FNSFS', updatedby='CDM-30409', updatedon=now()  where teammemberid='6197a90e-7378-42b7-987e-c17961053da6' and activeflag=1;

--roberta.contee-murray@maryland.gov
-- this is good

--'cathleen.barefoot@maryland.gov'
--changed to fiscal worker
select * from cjams.rolemapping where principalid = '3950' and activeflag=1 and teamtypekey='CW';
update cjams.rolemapping set roleid='1052', updatedby='CDM-30409', updatedon=now() where principalid = '3950' and activeflag=1 and teamtypekey='CW';
update cjams.teammember set roletypekey='FNSFW', updatedby='CDM-30409', updatedon=now()  where teammemberid='e8a56ef0-4dc8-4311-8662-2894df5ed2c4' and activeflag=1;

--kerry.logue@maryland.gov
--changed to fiscal worker
select * from cjams.rolemapping where principalid = '3936' and activeflag=1 and teamtypekey='CW';
update cjams.rolemapping set roleid='1052', updatedby='CDM-30409', updatedon=now() where principalid = '3936' and activeflag=1 and teamtypekey='CW';
update cjams.teammember set roletypekey='FNSFW', updatedby='CDM-30409', updatedon=now()  where teammemberid='9f92f034-6e45-4eca-84c5-1622ff927ac4' and activeflag=1;

--latasha.bradley-mose@maryland.gov
--changed to fiscal worker
select * from cjams.rolemapping where principalid = '3393' and activeflag=1 and teamtypekey='CW';
update cjams.rolemapping set roleid='1052', updatedby='CDM-30409', updatedon=now() where principalid = '3393' and activeflag=1 and teamtypekey='CW';
update cjams.teammember set roletypekey='FNSFW', updatedby='CDM-30409', updatedon=now()  where teammemberid='49132568-1411-4fc9-898a-d59874e1a7e6' and activeflag=1;
