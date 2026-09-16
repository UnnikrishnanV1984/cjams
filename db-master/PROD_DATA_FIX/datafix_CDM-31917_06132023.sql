-- CDM-31917 - Subsidy rate shows review but payment interfaced
/*
-- Issue Description: 
   GAP rate for 2 children still under review but the provider payment has been generated for May 2023

-- Case ID: 3201868
-- Provider ID: 5075922	(Claude Mcdavid) 

-- Client ID: 3410467 (BRITTANY RICE) - b891ed78-f13c-4611-b9fe-59597c1d3c69
-- GAP ID: 3824 - 2015-05-05 To 2030-06-06 - 4b3cd7f1-a96c-454b-8902-4286e533ebc2

-- Client ID: 3410472 (BRIANNA RICE) - 0baf2c6e-83dd-4537-bb17-9cacb2bf5ac2
-- GAP ID: 3823 - 2015-05-05 To 2030-06-06 - 5bb3e75a-c231-4796-a15c-ec02f7c2c65b

-- Category/ Module: Accounts Payable (Finance Management) 
-- Root cause: User Role issue, Mavis Asare-Dwamenah (case worker) was having wrong role LDSSRW 
--             Due to which partial transaction happened for these 2 GAP rate approvals.  
--             This user issue was fixed with CDM-31795
-- Fix Provided: For this Issue, the datafix has been promoted to update both GAP rates as Approved.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Client ID: 3410467 (BRITTANY RICE) - b891ed78-f13c-4611-b9fe-59597c1d3c69
-- GAP ID: 3824 - 2015-05-05 To 2030-06-06 - 4b3cd7f1-a96c-454b-8902-4286e533ebc2
select eventcode, routingstatustypeid, remarks, fromroleid, toroleid, updatedby, updatedon
	from routing
where routingid 
	in (	'd2471ef4-2c8f-42c8-bde3-405669dd0dab',
			'9e526aac-8fae-4cee-acd9-87008b257674'
		)  ;

update routing
set fromroleid = 'CWCW',
	updatedby = 'CDM-31917', 
	updatedon = now()
where routingid 
	in (	'd2471ef4-2c8f-42c8-bde3-405669dd0dab',
			'9e526aac-8fae-4cee-acd9-87008b257674'
		)  ;


INSERT INTO cjams.routing
	(	routingid, eventcode, fromsecurityusersid, tosecurityusersid, 
		teamid, fromroleid, toroleid, objectid, routingstatustypeid, 
		activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, 
		old_id, routeddescription, servicerequestnumber, 
		objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, 
		etl_userid, etl_load_date, entityid, reassignnotes)
VALUES
	(	cjams.gen_random_uuid(), 'GARR', 'e27575b1-783d-4b26-a4ad-0985f8ad4d6e', '66a80882-f231-4882-a573-1b5a32c8e271', 
		'85802412-97aa-4f41-8e35-52f682c643f8', 'CWSP', 'CWCW', '0e0507c3-6a4e-4186-8a9d-0ec629f33389', 16, 
		1, 'CDM-31917', now(), 'CDM-31917', now(), true, '', 
		NULL, 'Guardianship Rate Approved ', '3201868', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL
	);

select approvalstatustypekey, approvaldate, updatedby, updatedon
	from gapratesrevision
where gaprateid = '0e0507c3-6a4e-4186-8a9d-0ec629f33389'
	and activeflag = 1 ;

update gapratesrevision
set approvalstatustypekey = '3047',
	approvaldate = '2020-06-01 00:00:00',
	updatedby = 'CDM-31917', 
	updatedon = now()
where gaprateid = '0e0507c3-6a4e-4186-8a9d-0ec629f33389'
	and activeflag = 1 ;

	
-- Client ID: 3410472 (BRIANNA RICE) - 0baf2c6e-83dd-4537-bb17-9cacb2bf5ac2
-- GAP ID: 3823 - 2015-05-05 To 2030-06-06 - 5bb3e75a-c231-4796-a15c-ec02f7c2c65b

select eventcode, routingstatustypeid, remarks, fromroleid, toroleid, updatedby, updatedon
	from routing
where routingid 
	in (	'00a9070b-a0d4-4415-a0e0-12bed900e4c1',
			'fc4df1e3-640f-4698-ba5d-0331ac2e342f'
		)  ;

update routing
set fromroleid = 'CWCW',
	updatedby = 'CDM-31917', 
	updatedon = now()
where routingid 
	in (	'00a9070b-a0d4-4415-a0e0-12bed900e4c1',
			'fc4df1e3-640f-4698-ba5d-0331ac2e342f'
		)  ;


INSERT INTO cjams.routing
	(	routingid, eventcode, fromsecurityusersid, tosecurityusersid, 
		teamid, fromroleid, toroleid, objectid, routingstatustypeid, 
		activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, 
		old_id, routeddescription, servicerequestnumber, 
		objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, 
		etl_userid, etl_load_date, entityid, reassignnotes)
VALUES
	(	cjams.gen_random_uuid(), 'GARR', 'e27575b1-783d-4b26-a4ad-0985f8ad4d6e', '66a80882-f231-4882-a573-1b5a32c8e271', 
		'85802412-97aa-4f41-8e35-52f682c643f8', 'CWSP', 'CWCW', '959bdff5-d754-4359-9bc5-0f135fc96167', 16, 
		1, 'CDM-31917', now(), 'CDM-31917', now(), true, '', 
		NULL, 'Guardianship Rate Approved ', '3201868', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL
	);
	
select approvalstatustypekey, approvaldate, updatedby, updatedon
	from gapratesrevision
where gaprateid = '959bdff5-d754-4359-9bc5-0f135fc96167'
	and activeflag = 1 ;

update gapratesrevision
set approvalstatustypekey = '3047',
	approvaldate = '2020-06-01 00:00:00',
	updatedby = 'CDM-31917', 
	updatedon = now()
where gaprateid = '959bdff5-d754-4359-9bc5-0f135fc96167'
	and activeflag = 1 ;
