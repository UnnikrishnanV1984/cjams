/*
Issue Description:Data fix to remove the incorrect person card (Client ID: 204100172) from the CPS AR # 251023016621.
Category/Module: Bug
Root cause: Data fix to remove the incorrect person card (Client ID: 204100172) from the CPS AR # 251023016621.
Fix provided: Fix has been promoted to change the description to Father
Data/Code fix ticket#: CJAMS-58412
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
*/

update intakeservicerequestactor set activeflag = 0,
updatedby = 'CJAMS-58412', updatedon = now()
where personid = '5b11e24f-d762-4e48-b2ee-c12d77229cb4' and 
actorid = 'f161d775-81b2-4f01-86ae-01472755b20b'
and activeflag = 1 ;

update actor set activeflag = 0,
updatedby = 'CJAMS-58412', updatedon = now()
where personid = '5b11e24f-d762-4e48-b2ee-c12d77229cb4'
and actorid = 'f161d775-81b2-4f01-86ae-01472755b20b'
and activeflag = 1 ;

update personrole set activeflag = 0,
updatedby = 'CJAMS-58412', updatedon = now()
where personid = '5b11e24f-d762-4e48-b2ee-c12d77229cb4' 
and personroleid = 'ff860ee4-96f1-4111-ac9a-37b80f2ac7a8' 
and activeflag = 1 ;

update personprogramarea set activeflag = 0, 
updatedby = 'CJAMS-58412', updatedon = now() 
where   personid = '5b11e24f-d762-4e48-b2ee-c12d77229cb4' 
and activeflag = 1;

update personroletype set activeflag = 0, 
updatedby = 'CJAMS-58412', updatedon = now() 
where personroleid = 'ff860ee4-96f1-4111-ac9a-37b80f2ac7a8' 
and activeflag = 1 ;

update actorrelationship set activeflag = 0, 
updatedby = 'CJAMS-58412', updatedon = now() 
where intakeservicerequestactorid = '5907dee6-9f02-47cb-8df7-6bfc925bc3ed' 
and activeflag = 1;