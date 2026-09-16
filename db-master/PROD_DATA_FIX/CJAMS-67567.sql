
/*
Issue Description: multiple cases created from one intake
Category/Module: Error
Root cause: user requested to delete the program assignments for 
261023748284
261023748285
261023748286
261023748290
261023748291
Fix provided: Data fix is done to decative the active program assignments
Data/Code fix ticket#: CJAMS-67567
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: 
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/






--updated intakeservicerequest
update
	intakeservicerequest
set
	activeflag = 0,
	updatedby = 'CJAMS-67567',
	updatedon = now()
where
	servicerequestnumber in ('261023748284','261023748285','261023748286','261023748290','261023748291')
	and activeflag = 1;
--updated intakeservicerequestactor
update
	intakeservicerequestactor
set
	activeflag = 0,
	updatedby = 'CJAMS-67567',
	updatedon = now()
where
	intakeservicerequestactorid in ('81bddaec-35d7-4390-b1ab-2205d6106e95',
	'ddea4cae-c921-4c7d-a976-9baa917cb3c4','3a35a813-9170-44c2-a175-09442cc17eb9','d68100e3-27a1-451e-bc05-d0987f04f169','ced6a9d0-128f-4575-9e61-31e266d1fd30',
	'7078d850-9bdf-405a-bebb-d2342733b61f','349e6e17-d0c7-472f-b8ce-6ec67cd91d9a','67866812-4b47-4212-958a-d9ea58528a2d','aca48a20-41c6-4a1c-97e9-4f69dc76b60d',
	'359e0330-6be6-4284-aa9e-4d34f9f706cf','38e1ddd0-c9cb-4a8c-bc98-e06bd2c7fb95','3ed1770f-315d-4805-8bdd-b55ef9c7f31b','910369dd-3a11-4c59-b983-a3227c7f3059','2e196d01-c465-404f-8b56-4f0962d846f6',
	'cea204da-25ea-4d42-880e-9cf9a8bf0b67','dbedf3fe-2c86-4700-8121-bd0eafeb1d5f','9e1fea9d-8b45-499c-b86a-d3668c3efb5e','5afaa60e-7efc-43a2-a8fb-a19858a79ba3',
	'16dfbda9-ede2-42cc-b103-efc47df1c494','aba79ff0-447b-44e4-8c06-c4d8b3372026','bf2a96d5-85d8-4ac0-a3b4-fc1ecd2a2190','8356377b-b057-4deb-9959-b1e3cb59e3be',
	'4f4f4d4a-8bd0-4a07-91d8-8f86bcae72d3','a3c28744-25af-4a91-8738-64e16f40b5a3','c5afc0d1-5cc6-439f-8cff-94d30e5dc376')
	and activeflag = 1;

--updated actor

update
	actor
set
	activeflag = 0,
	updatedby = 'CJAMS-67567',
	updatedon = now()
where
	actorid in ('e6ed5664-5b78-4fb2-9868-4fb84594d5b9','c534b0bc-0d99-423a-b95f-80ec46dd3212','1afcb029-0386-4abc-a948-07f2f350f6a4','99929505-b6f3-42c8-a9ee-3dfc64d4891d','c85e8fb6-b6d3-4645-a35f-6455c6e17319',
	'9b908737-3d56-4c3c-8677-dff36e746514','b46826e8-887d-484c-b1b3-9cadfb6bdae4','3597437a-6500-475c-a780-5df5a14d6797','53f48522-917f-47c0-aaaa-dff4c51fb5b1','d79d891a-426c-41b0-bac3-9c108f47c16a')
	and activeflag = 1;


--updated intakeservrequestsdmmaltreatment
update
	intakeservrequestsdmmaltreatment
set
	activeflag = 0,
	updatedby = 'CJAMS-67567',
	updatedon = now()
where
	intakeservicerequestsdmid in (
		select intakeservicerequestsdmid
	from
		intakeservicerequestsdm
	where intakeserviceid in('b8e321d2-92da-4eec-88b3-4907bd2de788','9b400f7d-fdf8-47dd-9450-e9a4b9856032','82966021-cd9c-4243-b1d9-f172fbc5cb35',
'bc7d20a0-8059-4962-871c-da85b8fd4f73','41df0cdc-405c-48e6-872f-d405a0c1720d')	and activeflag = 1)
	and activeflag = 1;

--updated intakeservicerequestsdm
update
	intakeservicerequestsdm
set
	activeflag = 0,
	updatedby = 'CJAMS-67567',
	updatedon = now()
where
	intakeserviceid in('b8e321d2-92da-4eec-88b3-4907bd2de788','9b400f7d-fdf8-47dd-9450-e9a4b9856032','82966021-cd9c-4243-b1d9-f172fbc5cb35',
'bc7d20a0-8059-4962-871c-da85b8fd4f73','41df0cdc-405c-48e6-872f-d405a0c1720d')
	and activeflag = 1;


--updated personprogramarea
update
	personprogramarea
set
	activeflag = 0,
	updatedby = 'CJAMS-67567',
	updatedon = now()
where
	personprogramid in ('94f9d854-99b9-45fe-88ac-884958ad72ac','561ca09d-b92d-4117-a78f-c7ed4b24493e','75e4414a-e667-4771-97fb-c03431194126','0893775a-b90d-4a43-bed0-4750d69ee6da',
	'b68ba9c6-1879-4595-865e-01aa6523aca6','4b9ef45e-5fb1-4a94-a7d7-bf3f2641908e','7238cb5a-10d6-4198-9782-9222f64e55fd','13c0e6bf-bd4e-48c2-9e7e-ab757aae366b','9e217bb1-2351-4829-a3c6-84376fb629d1',
	'2a8d4287-b38a-44ac-a37b-f80d886132bd') 
	and activeflag = 1;
	


update
	intakeservicerequestdispositioncode
set
	activeflag = 0,
	updatedby = 'CJAMS-67567',
	updatedon = now()
where
	intakeserviceid in ('b8e321d2-92da-4eec-88b3-4907bd2de788','9b400f7d-fdf8-47dd-9450-e9a4b9856032','82966021-cd9c-4243-b1d9-f172fbc5cb35',
'bc7d20a0-8059-4962-871c-da85b8fd4f73','41df0cdc-405c-48e6-872f-d405a0c1720d')
	and activeflag = 1;
	


update
	personrole 
set
	activeflag = 0,
	updatedby = 'CJAMS-67567',
	updatedon = now()
where
	personroleid  in ('82c5e8aa-0453-48a2-bf48-9cfe3edfe335','10938f89-a480-4d0f-8f16-8bf80ac72d32','7f595111-7c86-4465-b4ed-3e41a9996281','f6b676f4-9399-498e-998c-814876035095',
	'f3b251f0-f8c1-4412-b297-563f3965031c','c1bb2677-6b5b-496d-8bfd-d0e538969f4d','077a5254-f836-42c1-8c55-a9e2b05b75ab','fa6db89a-4f78-4d8b-9b81-463a717435ed','05bdc23f-79c3-45e8-8069-9a7cb8329237','0c174f01-190d-4e26-bab5-7231fab8fafc')
	and activeflag = 1;
	


update
	actorrelationship
set
	activeflag = 0,
	updatedby = 'CJAMS-67567',
	updatedon = now()
where
	actorrelationshipid  in ('ea991f28-156a-416f-9395-3db5aa34cb13','16a7bda7-3348-4129-b57c-7a1ca1f7bd72','cd0803c4-28ba-4ba2-ad69-16c5a62f478c',
	'b80dc43d-06fd-425b-bacf-989ecf4e6057','90d84343-1679-4ca8-bd4d-4e2f00327549','a4bc4805-048f-43b3-aad3-c6dd6ae08704','e8e6ede3-db8e-4e18-bcf0-0167d4030859','d746e224-ed9b-4396-a919-55e148c23c16',
	'bec1a25f-7b57-4286-a442-a64b4397f2bb','38d3b827-d078-4a32-a664-f088ec8b9d6d','70dcebfd-8639-4a7f-a805-d1d3325a99b1','88b7c5e8-54be-4398-9b65-69369461aba8','452b24d4-4110-4164-92d4-5ce174551bb1','63c0a0d6-10b1-4ed7-88fb-f150ca5486b3',
	'0a264172-366a-40f4-8012-f2e640efea22','078b91a1-b136-449a-a194-abefb9a8acbf','65469bba-a05c-4fe9-8e7d-f3a854920898','23bb0d6c-dba8-4f19-a349-3a40a3a70cd5','a7e7d048-d5ae-41ce-ba9f-038e5be3fd82',
	'c1ed992f-a719-48b6-b181-9c23c87509f2','6813c7dc-66ca-46b0-b9ed-f7b295ee90a8','4fe6cc63-5b0a-4427-a332-c53e85e7e269','ee247420-6702-4183-ae03-bb1eb89c91fa','25c2547e-fbf6-4478-8df9-feb17f51d117',
	'c5835908-d7b9-460c-815f-e64c7d11f843')
	and activeflag = 1;
	


update
	personroletype 
set
	activeflag = 0,
	updatedby = 'CJAMS-67567',
	updatedon = now()
where
	personroleid  in ('82c5e8aa-0453-48a2-bf48-9cfe3edfe335','10938f89-a480-4d0f-8f16-8bf80ac72d32','7f595111-7c86-4465-b4ed-3e41a9996281','f6b676f4-9399-498e-998c-814876035095',
	'f3b251f0-f8c1-4412-b297-563f3965031c','c1bb2677-6b5b-496d-8bfd-d0e538969f4d','077a5254-f836-42c1-8c55-a9e2b05b75ab','fa6db89a-4f78-4d8b-9b81-463a717435ed','05bdc23f-79c3-45e8-8069-9a7cb8329237','0c174f01-190d-4e26-bab5-7231fab8fafc')
	and activeflag = 1;