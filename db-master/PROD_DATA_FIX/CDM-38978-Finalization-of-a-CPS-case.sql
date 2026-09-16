/*
Issue Description: Case assigned to the user are not available on the appeal worker dashboard (cases are listed in the next comment). Need technical analysis on why the cases are not available in the user dashboard and need fix for the same.
Category/ Module : Bug
Root cause: Routing table did not have APPL in eventcode or 15 in routingtypekey for concerned records
Fix provided :yes, write Db query and provided analysis
Code fix ticket#: CDM-38978
Reason why no related code fix: Status of the code fix  already submitted 
Status of the code fix if already submitted and expected prod fix date: 
void the rejected provider placement from backend
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--NOTE: 221020136049 CASE NOT FOUND and 211020138337 HAS BEEN ROUTED TWICE TO APPEALS

update routing 
set 
	eventcode = 'APPL', --Event set to appeal
	routingstatustypeid = 15 --Status set to review
	updatedby = 'CDM-38978',
	updatedon = now()
	where objectid in ('7a4596da-6e14-4d32-bc14-444b11d745d7', '688a74db-8643-4109-abac-047041159bd6', '4aa35666-450c-4ef2-9c29-212154fa76f6',
		'6aede2c8-2464-4f8b-a9b0-d8d469ec6205', '1fced197-8860-4f78-a952-8b0d04a7ed03', 'b0d58b9c-0eb6-4c74-83f1-649a582f31e4',
		'6053b8c5-e6bc-4589-b41a-2ba32dca038d', '0b36a586-de84-47ff-9a33-2440454706a9', 'ed779bdb-49fa-487f-ba31-9301fc7e4036',
		'362250cb-b8c8-444f-a45f-079e796b408e', 'bd9e498e-8496-4658-a66f-06fffd78f922', 'c73a59a6-0d5d-4fb3-8167-c77e11bbfa34',
		'5cd1b059-488a-4d42-b0ba-34cfbea08f6a', 'e33a4736-7681-48a2-906c-74e1cec27c69', 'd378f9c1-c592-4c68-a625-67ae2527fe1d',
		'b1565b9a-23c7-4a7f-8881-0de326c3c74c', '64bc8cb9-74b8-4ec0-bd5b-f5f644fc637d', 'd6c89aad-714d-4ec1-895b-07c476e5e7c6',
		'9632b751-7d4f-433e-86ee-6a0b3066ce54', '622ddd13-bdde-4f9c-afc1-37bf1546de0d', '7d09d33e-ba30-469b-b756-347c45ba272c',
		'f39ad09e-3ac4-44d6-874c-5aee0a3fdf7e', '4d51a0d6-2f38-43e5-a1b7-39e0cc31f07e', '565ebe87-b7c4-4408-9444-c16b3dfffb32',
		'dc89a1cb-f126-4cec-a7d2-e822caf3e01b', 'e4b71b61-39d3-42a2-8aa2-ab911e84f6c1', '8a6089fd-7648-4997-a99b-2e4d81470ed9',
		'c7fc2184-af75-47e7-a4b8-34374fc5d3dd', '03c2ade9-77fe-4212-acea-89c93b331297', 'c6c562ec-28d9-44af-a623-a6d728ed7e05',
		'0398b97a-f14f-41c8-91b9-7048e8cfb4cf', '22f1c2a9-229c-4e4d-a6f8-08ab3467ecef', '6d1e4280-5b50-4c74-931d-a0683a1d72c0',
		'9a7b0a81-1261-4af9-831d-571695151fd3', '6204ecd9-17d5-4ae4-b9d2-965953e97b0f', '77e358ae-9e6c-4078-a2f4-7e33214811f5',
		'88135f56-ec84-4a77-9625-c0c3874778a1', 'f3a5e08e-1db0-424f-940a-2a4afe77ca1d', '14700ad1-ea9b-4d51-a79c-9360ede1d33f',
		'a28b1908-c2e9-4c7e-a5d4-9b8fc4b3cff4', 'bd138b45-9418-4808-8531-4f6691b7ef45', 'a8fbc46c-50a3-47ea-b8d5-9ac3dd26a011',
		'3c49803c-590b-437d-8b43-71b4ad79078e', 'd1725841-5120-441c-8560-0f3b750af452', 'd42f2375-fb63-4ac7-8cd0-55a9852a42bf',
		'0aea7682-a8a2-4ba4-9368-7c22d251da8a', 'e927feca-a1e7-40ef-9211-cdcc39a20482', 'd2a1b99b-a2d6-4b21-baf6-d9a2191c0948',
		'f00969ce-8b60-40fc-958a-49feb44005ab', '35ae5c8d-3355-4298-959c-c0fdc1aced3b', 'b155698c-2857-4124-8d86-88b50c5ea7a4',
		'96b8ee4d-9cd3-434c-bc7a-d44ff2ece705', '4ab29f1f-fee9-4583-bfbd-d6b6c50e34e6', '494f1e16-50c3-4dc2-a483-c883291b068b',
		'889478ad-1029-40ac-a079-f0df2d4ba7d6', 'fedf107c-e7f1-469c-95d2-075cd44e380d')
	and tosecurityusersid = '1019e183-a7ab-4244-a728-854f03a3a477'
	and activeflag = 1;