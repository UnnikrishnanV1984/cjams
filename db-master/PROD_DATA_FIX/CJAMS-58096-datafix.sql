/*
Issue Description: User requested to Remove person ID #s 204058630 and 204058632 from CPS-IR 251023007101 and I251013235625
and also Add person person ID #s 1526967 and 3381658 to intake referral # I251013235625
Category/Module: Bug
Root cause: User requested update Maltreator to unknown person
Fix provided: DB queries to insert unknown person and change Maltreator 
Data/Code fix ticket#: CJAMS-58096
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
*/


update intakeservicerequestactor set activeflag = 0,updatedby = 'CJAMS-58096', updatedon = now()
where personid in ('5651cfe5-d9db-4499-9e4d-aea80d4e8e75','4c1ba9ce-a796-4a1e-8570-0fba41464692') and 
actorid in ('d191650f-0d24-4f3e-86e2-2444a291dc4a','b138c60d-5966-4551-a21d-263caa3eb904')
and activeflag = 1;

update actor set activeflag = 0,updatedby = 'CJAMS-58096', updatedon = now()
where personid in ('5651cfe5-d9db-4499-9e4d-aea80d4e8e75','4c1ba9ce-a796-4a1e-8570-0fba41464692') and 
actorid in ('d191650f-0d24-4f3e-86e2-2444a291dc4a','b138c60d-5966-4551-a21d-263caa3eb904')
and activeflag = 1;

update personrole set activeflag = 0,updatedby = 'CJAMS-58096', updatedon = now()
where personid in ('5651cfe5-d9db-4499-9e4d-aea80d4e8e75','4c1ba9ce-a796-4a1e-8570-0fba41464692')
and activeflag = 1;

update personprogramarea set activeflag = 0, updatedby = 'CJAMS-58096', updatedon = now() 
where   personid in ('5651cfe5-d9db-4499-9e4d-aea80d4e8e75','4c1ba9ce-a796-4a1e-8570-0fba41464692') and activeflag = 1;

update personroletype set activeflag = 0, updatedby = 'CJAMS-58096', updatedon = now() 
where personroleid in ('abcc85d5-4659-4fdf-9086-abdeb032be9f',
'89ebf599-c69f-42ee-8562-236114cc0b74') and activeflag = 1;


update actorrelationship set activeflag = 0, updatedby = 'CJAMS-58096', updatedon = now() 
where intakeservicerequestactorid in ('6bf546ff-fd8e-4686-a864-8199d66683fd',
'21615b1a-4d0f-484f-b214-d718c8100a79','5d0004bb-3bd1-4159-8d9f-c2e994d2c47a') and activeflag = 1;

--------------------

update intakeservicerequestactor set activeflag = 0,updatedby = 'CJAMS-58096', updatedon = now()
where personid in ('5651cfe5-d9db-4499-9e4d-aea80d4e8e75','4c1ba9ce-a796-4a1e-8570-0fba41464692') and 
actorid in ('6d9f6651-d12e-4ad8-836b-b82fc9fc14ec','f8b283c9-c0ef-4e2e-83b8-16c15874c40a')
and activeflag = 1;

update actor set activeflag = 0,updatedby = 'CJAMS-58096', updatedon = now()
where   personid in ('5651cfe5-d9db-4499-9e4d-aea80d4e8e75','4c1ba9ce-a796-4a1e-8570-0fba41464692') and activeflag = 1
and actorid in ('6d9f6651-d12e-4ad8-836b-b82fc9fc14ec','f8b283c9-c0ef-4e2e-83b8-16c15874c40a');

update personrole set activeflag = 0,updatedby = 'CJAMS-58096', updatedon = now()
where personid in('5651cfe5-d9db-4499-9e4d-aea80d4e8e75','4c1ba9ce-a796-4a1e-8570-0fba41464692') and activeflag = 1
and intakeserviceid = '7c5bcdd0-c2c1-4669-befb-dd177621e50a' ;

update personroletype set activeflag = 0, updatedby = 'CJAMS-58096', updatedon = now() 
where personroleid in ('8cfa7fd1-ca9e-4db2-a348-e142e28e8803','bef5e118-f42c-48a7-b078-b8f56b0db8de') and activeflag = 1;


update actorrelationship set activeflag = 0, updatedby = 'CJAMS-58096', updatedon = now() 
where intakeservicerequestactorid in ('96fc2e15-e4f6-4fc6-98db-8529ca91c970','dd3ba986-cdb5-4609-b1c8-fc1cd0d3a4cc')and activeflag = 1;

--Add person person ID #s 1526967 and 3381658 to intake referral # I251013235625

update intakeservicerequestactor set intakenumber = 'I251013235625',
updatedby = 'CJAMS-58096', updatedon = now() 
where personid in ('049c6f1a-b19f-460e-85bb-3c79840a2278','adfc6d5c-d61b-446e-9922-4c5cb78f96cd')
and intakeserviceid = '7c5bcdd0-c2c1-4669-befb-dd177621e50a' and activeflag = 1;
