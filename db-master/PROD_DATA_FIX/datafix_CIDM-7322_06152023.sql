-- CIDM-7322 - Missing Person/HOH from the case (isprimary column issue)
/*
-- Issue Description: 
   Missing Person/HOH from the case (isprimary column issue) ticket to fix all impacted cases

-- Category/ Module: Removal (Case Management) 
-- Root cause: CJAMS was havign a code issue, which was fixed and deployed in production
-- Fix Provided: Data cleanup Missing Person/HOH from the case (isprimary column issue) 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select personid, actorid, isprimary, intakeservicerequestpersontypekey, updatedby, updatedon
	from intakeservicerequestactor acr
where intakeservicerequestactorid in 
	(
		'7dfaa116-757c-4fc3-bd27-041aecb552fa', '93249ebe-1549-4602-b543-21908726358d', 'aceca17b-0cc4-4e6c-8fed-a430eeb07efa',
		'c420259b-aa54-4f59-b4c1-5422b01dfb2f', '4b29ed78-c4f7-4c47-b493-87b542ceb3b8', 'e70114f2-8f38-405a-801e-cc1791127767',
		'e3f87ced-5785-4c21-aa76-a5f6dedc33b9', 'ce24da25-ab42-4ad5-a467-38c010a95111', '09ebc172-3825-45e0-b8bf-0015456b4657',
		'37f42788-86d5-47bd-ab39-4068800401c6', '38401a6e-e814-4774-858b-164b0d719246', '2398af93-631c-4f4d-9e6a-fe10121be1dd',
		'39ee8e3c-2912-4111-914e-10500fed8225', 'e63be008-7358-42e7-880d-16b65bb6c7bb', 'b7dc9e06-e312-48f4-83eb-d4cdaa857df6',
		'82d5a73e-0936-4046-b892-33a1270de77c', 'ea4da095-a212-4c24-8720-07cca6c49f34', '3dbd425d-1b32-4259-bd59-9ee4631522c9',
		'81d198c6-905d-46d8-9f5b-443efeec69f3', '0c044bdd-603d-4282-87d8-70dc958cf0a3', '98589e23-e04f-42ec-8127-8043c0d53900',
		'73406ecb-5f9b-4733-aef5-5fc24554eeae', 'e618535b-c683-49ed-b527-9618bf8dd2a9', '1a36d289-e949-416b-9f93-b35b262d2508',
		'53877d81-4947-432b-a8a8-b29dec62a531', 'b9caf72d-d931-416a-b459-90bc533a8e68', 'd8054826-3a9d-489b-9d87-8e96c3f66222',
		'22926a5b-cefb-4d6b-ae98-4d2b4e1887b4', 'ff1a4ca2-2163-4458-b124-21e063a5fde4', '9073fed9-be88-4e99-8966-e825fe1a7525',
		'414a33ca-32a5-43eb-96cc-e2db7a70ed37', 'ef26720b-2ed1-4c62-a0d5-e39f8e027dc9', 'ea0b153b-d4fd-44f9-8bdd-87fded20bd2b',
		'c76afaf2-038a-4daf-b6ec-198c6de24e96', '2d7da0e8-ce1c-45ea-82ec-bd297904e185', 'b25d998b-6558-4788-8994-39600896ba74',
		'25b354e0-523d-470b-af58-3286001030c8', '6ae18ed5-6a26-4b1a-8ea6-d4ee1ad36b35', 'ad9bb211-efd9-4631-bd67-efd237b1d926',
		'9c59e825-a406-49fe-b79e-f56222fa347c', '93226a8c-a3bc-45db-9155-360a9a8bbb23', '7ec9cd7b-bd09-4b8e-b553-7642ed59b975',
		'ae5e2500-0a63-4cdb-a58f-f70df1a33bef', 'fdf50f93-ca42-475b-9252-cd73d7789fef', '09a5f0e8-5c38-4388-85e4-f00d31802547',
		'37036df9-1c69-4a9e-a7d6-b4a188fc58a3', 'b0a006fd-0592-4355-9294-6610961628a4', 'b04dacd9-c067-4421-a270-abb5a42d55b8',
		'696c9f71-5b42-4049-bb77-5526bd5fa6f5', '7b0343e2-2065-4a04-bedc-b5abf26f1e8b', 'a05e9c28-0195-461d-9f9d-335b82d387f1',
		'cac32def-01d9-4afe-8b57-3f5133e593ac', '6475974f-f09f-40af-b23b-2e88ace30abb', '69c1a0df-d4b2-4672-89a3-056fd1b0cd24'
	)
	and activeflag = 1
	and isprimary = false
	and (select count(*) 
			from intakeservicerequestactor acr1
		 where acr1.actorid = acr.actorid
			and acr1.isprimary = true
			and acr1.activeflag = 1
	) = 0 ;


update intakeservicerequestactor acr
set isprimary = true,
	updatedby = 'CIDM-7322',
	updatedon = now()
where intakeservicerequestactorid in 
	(
		'7dfaa116-757c-4fc3-bd27-041aecb552fa', '93249ebe-1549-4602-b543-21908726358d', 'aceca17b-0cc4-4e6c-8fed-a430eeb07efa',
		'c420259b-aa54-4f59-b4c1-5422b01dfb2f', '4b29ed78-c4f7-4c47-b493-87b542ceb3b8', 'e70114f2-8f38-405a-801e-cc1791127767',
		'e3f87ced-5785-4c21-aa76-a5f6dedc33b9', 'ce24da25-ab42-4ad5-a467-38c010a95111', '09ebc172-3825-45e0-b8bf-0015456b4657',
		'37f42788-86d5-47bd-ab39-4068800401c6', '38401a6e-e814-4774-858b-164b0d719246', '2398af93-631c-4f4d-9e6a-fe10121be1dd',
		'39ee8e3c-2912-4111-914e-10500fed8225', 'e63be008-7358-42e7-880d-16b65bb6c7bb', 'b7dc9e06-e312-48f4-83eb-d4cdaa857df6',
		'82d5a73e-0936-4046-b892-33a1270de77c', 'ea4da095-a212-4c24-8720-07cca6c49f34', '3dbd425d-1b32-4259-bd59-9ee4631522c9',
		'81d198c6-905d-46d8-9f5b-443efeec69f3', '0c044bdd-603d-4282-87d8-70dc958cf0a3', '98589e23-e04f-42ec-8127-8043c0d53900',
		'73406ecb-5f9b-4733-aef5-5fc24554eeae', 'e618535b-c683-49ed-b527-9618bf8dd2a9', '1a36d289-e949-416b-9f93-b35b262d2508',
		'53877d81-4947-432b-a8a8-b29dec62a531', 'b9caf72d-d931-416a-b459-90bc533a8e68', 'd8054826-3a9d-489b-9d87-8e96c3f66222',
		'22926a5b-cefb-4d6b-ae98-4d2b4e1887b4', 'ff1a4ca2-2163-4458-b124-21e063a5fde4', '9073fed9-be88-4e99-8966-e825fe1a7525',
		'414a33ca-32a5-43eb-96cc-e2db7a70ed37', 'ef26720b-2ed1-4c62-a0d5-e39f8e027dc9', 'ea0b153b-d4fd-44f9-8bdd-87fded20bd2b',
		'c76afaf2-038a-4daf-b6ec-198c6de24e96', '2d7da0e8-ce1c-45ea-82ec-bd297904e185', 'b25d998b-6558-4788-8994-39600896ba74',
		'25b354e0-523d-470b-af58-3286001030c8', '6ae18ed5-6a26-4b1a-8ea6-d4ee1ad36b35', 'ad9bb211-efd9-4631-bd67-efd237b1d926',
		'9c59e825-a406-49fe-b79e-f56222fa347c', '93226a8c-a3bc-45db-9155-360a9a8bbb23', '7ec9cd7b-bd09-4b8e-b553-7642ed59b975',
		'ae5e2500-0a63-4cdb-a58f-f70df1a33bef', 'fdf50f93-ca42-475b-9252-cd73d7789fef', '09a5f0e8-5c38-4388-85e4-f00d31802547',
		'37036df9-1c69-4a9e-a7d6-b4a188fc58a3', 'b0a006fd-0592-4355-9294-6610961628a4', 'b04dacd9-c067-4421-a270-abb5a42d55b8',
		'696c9f71-5b42-4049-bb77-5526bd5fa6f5', '7b0343e2-2065-4a04-bedc-b5abf26f1e8b', 'a05e9c28-0195-461d-9f9d-335b82d387f1',
		'cac32def-01d9-4afe-8b57-3f5133e593ac', '6475974f-f09f-40af-b23b-2e88ace30abb', '69c1a0df-d4b2-4672-89a3-056fd1b0cd24'
	)
	and activeflag = 1
	and isprimary = false
	and (select count(*) 
			from intakeservicerequestactor acr1
		 where acr1.actorid = acr.actorid
			and acr1.isprimary = true
			and acr1.activeflag = 1
	) = 0 ;
		
-- Make Inactive (Duplicate)
select personid, actorid, isprimary, intakeservicerequestpersontypekey, updatedby, updatedon
	from intakeservicerequestactor acr
where intakeservicerequestactorid in 
		( '308ad794-0c35-4461-8c9a-00d0d49e79a1', '07e4e939-878f-4794-ac07-a6091eeb435e', 'b2b4efd5-09d3-4358-9297-39c66e2dc383' )
	and activeflag = 1;
	
update intakeservicerequestactor 
set activeflag = 0,
	updatedby = 'CIDM-7322',
	updatedon = now()
where intakeservicerequestactorid in 
		( '308ad794-0c35-4461-8c9a-00d0d49e79a1', '07e4e939-878f-4794-ac07-a6091eeb435e', 'b2b4efd5-09d3-4358-9297-39c66e2dc383' )
	and activeflag = 1;
