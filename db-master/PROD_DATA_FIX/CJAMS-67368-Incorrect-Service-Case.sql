/*
Issue Description:
CPS IR# 261023742025 was wrongly connected to a Service Case# 3120674, should be connected to Service Case# 3225266 as confirmed by user.   

1. Service Case# 3120674 - Need to be reverted as closed on 02/03/2026, 06:30 PM (i.e. remove the last Open and Close history in Decision tab against 04/24/2026)

2. All information from CPS IR# 261023742025 are coming to case Service Case# 3120674, which needs to be removed (i.e. contacts, assessments details).  

3. Connect CPS IR# case 261023742025 with correct Service Case# 3225266 

Note: Ensure all contact and assessments in CPS IR# 261023742025 are available in the Service Case# 3225266

 Category/ Module: Data fix needed
 Root cause: unlink case and delete intake
 Pull request# N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/

update intakeservicerequest 
set servicecaseid=NULL,updatedby='CJAMS-67368',updatedon=now() 
where intakeserviceid='1f986473-716a-4c84-870d-9f3331fa94fa' and activeflag=1;


select * from cjams.createservicecase('1f986473-716a-4c84-870d-9f3331fa94fa','6ea8a5a4-e9ac-42ec-82e1-8224469d0ba2',0,'cc568620-e3c4-42a8-a9b0-d8a9e82956e7',NULL,'','intake',NULL);

update servicecasedisposition 
set activeflag=0,updatedby='CJAMS-67368',updatedon=now() 
where servicecasedispositionid='b101dea4-0f77-4487-adff-9c7d479b3907' and activeflag=1;


update servicecasedisposition 
set activeflag=0,updatedby='CJAMS-67368',updatedon=now() 
where servicecasedispositionid='33110b80-8542-4b28-b1a9-6250621092ff' and activeflag=1;

update servicecase 
set statustypekey = 'Closed', 
	dispositioncode = 'Closed', 
	enddate = '2026-02-03 18:30:00', 
	updatedby = 'CJAMS-67368',
	updatedon = now() 
where servicecasenumber = '3120674' 
	and activeflag  = 1 ;


    INSERT INTO cjams.servicecasedisposition
	(	servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, 
		"comments", effectivedate, 
		activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, 
		etl_userid, etl_load_date, supervisorcomment, reopenreasonkey)
VALUES
	(	cjams.gen_random_uuid(), '787394df-efec-4a74-9493-403e7e575628', '2026-02-03 18:30:00', 'Closed', 'Closed', 
		'closed', '2026-02-03 18:30:00', 
		1, 'CJAMS-67368 ', now(),  'CJAMS-67368', now(), NULL, '3120674', 
		NULL, NULL, NULL, NULL
	);
	