-- CDM-31240 - Missing assessments-In home case.
/*
-- Issue Description: 
   User reuest to fix the Child Removals / OOHs (ACQI reports priority)  

-- Case ID: 3163547 - 34194f81-2fa1-41dd-bf6e-389d5f87d668
-- Deleted Case ID: 231030108766 - 054fd9f2-9343-4254-ae46-9c76106420cb	

-- Category/ Module: Removal (Case Management) 
-- Root cause: Code Issue (Further analysis is in progress)  
-- Fix Provided: Datafix has been promoted to bring back all Missing assessments of this serviec case.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select (select atp.titleheadertext 
			from assessmenttemplate atp 
		where atp.assessmenttemplateid = amt.assessmenttemplateid
		) as assement_type,
	amt.assessmentid,
	amt.servicecaseid,
	amt.objectname,
	amt.objectid,
	amt.updatedby,
	amt.updatedon
from cjams.assessment amt
where amt.assessmentid 
	in (	'1e48c20e-7230-44a7-bc91-f72a97582e16', '08bf2a79-bd46-4005-ace2-abcc1a3f2bb2', '4863b770-4f8c-4dce-8eef-90774a9da6b1',
			'622560bb-c2cc-418c-a981-54b8f6d572da', 'f8bc79b3-1e2e-4caa-a9c7-3443f8d5cc7f', 'e74bb04a-8e0a-4184-aec6-b2c156c61c9b',
			'36b2e662-8306-44b8-b2eb-024ee66808af', '35d08e7a-7a14-4418-a610-795f5c6e38f7', 'd348dd25-fc2e-43f4-ab5b-238af37c2e92',
			'40e821bf-598e-47ad-92fd-137408f88c1a', 'bf97f396-8b15-43f1-bd6b-21e78642e93a', '1d44ef82-501b-434b-a7fa-7c9ceb64c23c',
			'79e18e9c-4167-4bdd-b5f8-902a2823152b', '1cfae685-a347-46a6-9c3d-a3fbe59aee56', '9c4073f8-8261-49f1-8060-b963ec130e50',
			'397c981b-9404-402f-bae0-28f6571d9a50', 'd974a6dd-c711-4b7d-9f64-b4d97668f97c', 'bc3fd2b9-dc98-4e27-931b-57e3d41b6ee2',
			'42e3b6af-c412-4128-8c20-b37c1036cd91', 'bf04fc80-bc83-4265-acd7-0fd9e7234607', 'd52825cb-b570-4135-b26b-8c06de11c4d1',
			'646fe904-c61b-47ef-8a5d-5c3e80b2149a', 'b83f980c-bf54-4b16-a187-cf0d88826c41', 'fdd6f214-1cd1-49bf-93fe-5fc0b87c2a24',
			'aa2a6a9c-e5f5-4509-af9b-29e11829626a', '933dab34-d068-447d-b87a-f8217874e38d', '63b060de-d3bf-447b-b499-3b6c9cb12804',
			'd24e84f0-4bea-49fa-b196-6ed83d0c1f4d', 'caef0003-70d1-4b24-991e-6b57dc8f20df', '963a8e36-9f1f-4be1-abca-70aee69cb2ad',
			'db76671a-0a35-462a-ae3f-d49a30a78bbe', 'a54abe0a-0dbf-4143-b8d7-c1b186dbfaf4', '1ceac9b9-8985-4b56-809b-be45f3950910',
			'32012025-098e-42cd-a227-96bd1b856457', '9e60dcf4-b152-4a28-8258-53aca9a62627', 'c1cf5c38-535e-44a8-b0c4-11c48e5031b8',
			'10b8daa6-ea8c-41da-a00c-0712c2c615b8', '237657c3-1a67-4bae-827d-e658fc42ed65', 'c94ef915-c6d4-4181-a79a-90ec9aac9be9',
			'b19e2dee-d758-486b-979f-45b0c79a7d7f', '5b6de39a-4b62-4ef4-bafd-9b17a8c1b455', 'eb0ae15c-8a28-4b43-a99b-320aba721a91',
			'3c6fb996-7743-4b9e-a933-9fd5843ebe89', '0f7d57fd-a472-41ce-bff5-c2512172bced', '9d562658-2de8-4213-961d-99ff1216f3b2',
			'59e93535-951c-4576-9660-fdd8444c64b8', '04a4c61b-aece-4899-bac5-5ffec14b94c9', 'a0c35f9a-2f45-49f9-aaf2-8268538037ac',
			'b196f084-0ce9-4326-8f47-4875f88b1991', '56a5112e-6f1e-4f41-bbd6-843b8f758de2', 'b1ef7b2f-7c05-4005-9942-455fa6329c1b',
			'0a536a57-e84c-46d3-a980-8920d87150b1', '3baf0385-3d1c-4b90-92e5-3bb7e8e843c0' 
		)
and amt.activeflag = 1
and amt.servicecaseid = '054fd9f2-9343-4254-ae46-9c76106420cb' -- Deleted Case ID: 231030108766 
order by assement_type ;

update cjams.assessment
set servicecaseid = '34194f81-2fa1-41dd-bf6e-389d5f87d668', -- 3163547
	updatedby = 'CDM-31240',
	updatedon = now()
where assessmentid 
	in (	
		'04a4c61b-aece-4899-bac5-5ffec14b94c9', '35d08e7a-7a14-4418-a610-795f5c6e38f7', '36b2e662-8306-44b8-b2eb-024ee66808af',
		'40e821bf-598e-47ad-92fd-137408f88c1a', '59e93535-951c-4576-9660-fdd8444c64b8', 'bf97f396-8b15-43f1-bd6b-21e78642e93a', 
		'd348dd25-fc2e-43f4-ab5b-238af37c2e92', 'e74bb04a-8e0a-4184-aec6-b2c156c61c9b', 'f8bc79b3-1e2e-4caa-a9c7-3443f8d5cc7f'
		)
and activeflag = 1
and servicecaseid = '054fd9f2-9343-4254-ae46-9c76106420cb' ; -- Deleted Case ID: 231030108766 

update cjams.assessment set servicecaseid = '34194f81-2fa1-41dd-bf6e-389d5f87d668', updatedby = 'MDE212311', updatedon = '7/28/2017  1:18:29 PM' where assessmentid = '237657c3-1a67-4bae-827d-e658fc42ed65' and activeflag = 1 ;
update cjams.assessment set servicecaseid = '34194f81-2fa1-41dd-bf6e-389d5f87d668', updatedby = 'MDE212311', updatedon = '4/7/2017  9:51:15 AM' where assessmentid = 'c94ef915-c6d4-4181-a79a-90ec9aac9be9' and activeflag = 1 ;
update cjams.assessment set servicecaseid = '34194f81-2fa1-41dd-bf6e-389d5f87d668', updatedby = 'MDE212311', updatedon = '5/21/2019  1:40:22 PM' where assessmentid = '10b8daa6-ea8c-41da-a00c-0712c2c615b8' and activeflag = 1 ;
update cjams.assessment set servicecaseid = '34194f81-2fa1-41dd-bf6e-389d5f87d668', updatedby = 'SSH233011', updatedon = '7/23/2008  9:11:19 AM' where assessmentid = 'b19e2dee-d758-486b-979f-45b0c79a7d7f' and activeflag = 1 ;
update cjams.assessment set servicecaseid = '34194f81-2fa1-41dd-bf6e-389d5f87d668', updatedby = 'MDE212311', updatedon = '8/17/2017  9:47:51 AM' where assessmentid = 'bf04fc80-bc83-4265-acd7-0fd9e7234607' and activeflag = 1 ;
update cjams.assessment set servicecaseid = '34194f81-2fa1-41dd-bf6e-389d5f87d668', updatedby = 'MDE212311', updatedon = '12/7/2017  10:24:49 AM' where assessmentid = 'd52825cb-b570-4135-b26b-8c06de11c4d1' and activeflag = 1 ;
update cjams.assessment set servicecaseid = '34194f81-2fa1-41dd-bf6e-389d5f87d668', updatedby = 'MDE212311', updatedon = '4/10/2017  7:54:13 AM' where assessmentid = 'bc3fd2b9-dc98-4e27-931b-57e3d41b6ee2' and activeflag = 1 ;
update cjams.assessment set servicecaseid = '34194f81-2fa1-41dd-bf6e-389d5f87d668', updatedby = 'MDE212311', updatedon = '12/3/2018  3:59:26 PM' where assessmentid = 'b83f980c-bf54-4b16-a187-cf0d88826c41' and activeflag = 1 ;
update cjams.assessment set servicecaseid = '34194f81-2fa1-41dd-bf6e-389d5f87d668', updatedby = 'MDE212311', updatedon = '5/14/2019  9:51:37 AM' where assessmentid = '622560bb-c2cc-418c-a981-54b8f6d572da' and activeflag = 1 ;
update cjams.assessment set servicecaseid = '34194f81-2fa1-41dd-bf6e-389d5f87d668', updatedby = 'MDE212311', updatedon = '1/29/2018  10:55:01 AM' where assessmentid = '646fe904-c61b-47ef-8a5d-5c3e80b2149a' and activeflag = 1 ;
update cjams.assessment set servicecaseid = '34194f81-2fa1-41dd-bf6e-389d5f87d668', updatedby = 'e22edb66-fce8-4b6c-8354-0ffe5e724d4a', updatedon = '8/10/2022  4:19:07 PM' where assessmentid = '9d562658-2de8-4213-961d-99ff1216f3b2' and activeflag = 1 ;
update cjams.assessment set servicecaseid = '34194f81-2fa1-41dd-bf6e-389d5f87d668', updatedby = 'MDE212311', updatedon = '3/1/2019  1:58:56 PM' where assessmentid = 'fdd6f214-1cd1-49bf-93fe-5fc0b87c2a24' and activeflag = 1 ;
update cjams.assessment set servicecaseid = '34194f81-2fa1-41dd-bf6e-389d5f87d668', updatedby = 'MDE212311', updatedon = '6/14/2017  3:11:28 PM' where assessmentid = '42e3b6af-c412-4128-8c20-b37c1036cd91' and activeflag = 1 ;
update cjams.assessment set servicecaseid = '34194f81-2fa1-41dd-bf6e-389d5f87d668', updatedby = 'e22edb66-fce8-4b6c-8354-0ffe5e724d4a', updatedon = '8/10/2022  4:21:33 PM' where assessmentid = '3c6fb996-7743-4b9e-a933-9fd5843ebe89' and activeflag = 1 ;
update cjams.assessment set servicecaseid = '34194f81-2fa1-41dd-bf6e-389d5f87d668', updatedby = 'e22edb66-fce8-4b6c-8354-0ffe5e724d4a', updatedon = '8/2/2022  12:17:24 PM' where assessmentid = '4863b770-4f8c-4dce-8eef-90774a9da6b1' and activeflag = 1 ;
update cjams.assessment set servicecaseid = '34194f81-2fa1-41dd-bf6e-389d5f87d668', updatedby = 'SSH233011', updatedon = '8/12/2009  9:43:43 AM' where assessmentid = '5b6de39a-4b62-4ef4-bafd-9b17a8c1b455' and activeflag = 1 ;
update cjams.assessment set servicecaseid = '34194f81-2fa1-41dd-bf6e-389d5f87d668', updatedby = 'e22edb66-fce8-4b6c-8354-0ffe5e724d4a', updatedon = '7/5/2022  3:20:32 PM' where assessmentid = '1e48c20e-7230-44a7-bc91-f72a97582e16' and activeflag = 1 ;
update cjams.assessment set servicecaseid = '34194f81-2fa1-41dd-bf6e-389d5f87d668', updatedby = 'SSH233011', updatedon = '7/7/2009  8:55:12 AM' where assessmentid = 'a54abe0a-0dbf-4143-b8d7-c1b186dbfaf4' and activeflag = 1 ;
update cjams.assessment set servicecaseid = '34194f81-2fa1-41dd-bf6e-389d5f87d668', updatedby = 'SSH233011', updatedon = '3/18/2009  3:33:41 PM' where assessmentid = '1ceac9b9-8985-4b56-809b-be45f3950910' and activeflag = 1 ;
update cjams.assessment set servicecaseid = '34194f81-2fa1-41dd-bf6e-389d5f87d668', updatedby = 'SSH233011', updatedon = '7/23/2008  9:28:24 AM' where assessmentid = '32012025-098e-42cd-a227-96bd1b856457' and activeflag = 1 ;
update cjams.assessment set servicecaseid = '34194f81-2fa1-41dd-bf6e-389d5f87d668', updatedby = 'MDE212311', updatedon = '12/8/2017  10:00:05 AM' where assessmentid = '63b060de-d3bf-447b-b499-3b6c9cb12804' and activeflag = 1 ;
update cjams.assessment set servicecaseid = '34194f81-2fa1-41dd-bf6e-389d5f87d668', updatedby = 'MDE212311', updatedon = '1/26/2018  1:27:42 PM' where assessmentid = '933dab34-d068-447d-b87a-f8217874e38d' and activeflag = 1 ;
update cjams.assessment set servicecaseid = '34194f81-2fa1-41dd-bf6e-389d5f87d668', updatedby = 'MDE212311', updatedon = '4/7/2017  9:46:44 AM' where assessmentid = '963a8e36-9f1f-4be1-abca-70aee69cb2ad' and activeflag = 1 ;
update cjams.assessment set servicecaseid = '34194f81-2fa1-41dd-bf6e-389d5f87d668', updatedby = 'MDE212311', updatedon = '5/10/2019  2:11:46 PM' where assessmentid = '9e60dcf4-b152-4a28-8258-53aca9a62627' and activeflag = 1 ;
update cjams.assessment set servicecaseid = '34194f81-2fa1-41dd-bf6e-389d5f87d668', updatedby = 'MDE212311', updatedon = '12/3/2018  11:56:26 AM' where assessmentid = 'aa2a6a9c-e5f5-4509-af9b-29e11829626a' and activeflag = 1 ;
update cjams.assessment set servicecaseid = '34194f81-2fa1-41dd-bf6e-389d5f87d668', updatedby = 'SSH233011', updatedon = '12/10/2008  11:55:38 AM' where assessmentid = 'c1cf5c38-535e-44a8-b0c4-11c48e5031b8' and activeflag = 1 ;
update cjams.assessment set servicecaseid = '34194f81-2fa1-41dd-bf6e-389d5f87d668', updatedby = 'MDE212311', updatedon = '6/14/2017  2:48:54 PM' where assessmentid = 'caef0003-70d1-4b24-991e-6b57dc8f20df' and activeflag = 1 ;
update cjams.assessment set servicecaseid = '34194f81-2fa1-41dd-bf6e-389d5f87d668', updatedby = 'MDE212311', updatedon = '9/8/2017  10:26:06 AM' where assessmentid = 'd24e84f0-4bea-49fa-b196-6ed83d0c1f4d' and activeflag = 1 ;
update cjams.assessment set servicecaseid = '34194f81-2fa1-41dd-bf6e-389d5f87d668', updatedby = 'MDE212311', updatedon = '2/28/2019  1:58:31 PM' where assessmentid = 'db76671a-0a35-462a-ae3f-d49a30a78bbe' and activeflag = 1 ;
update cjams.assessment set servicecaseid = '34194f81-2fa1-41dd-bf6e-389d5f87d668', updatedby = 'SSH233011', updatedon = '7/23/2008  9:04:27 AM' where assessmentid = 'b196f084-0ce9-4326-8f47-4875f88b1991' and activeflag = 1 ;
update cjams.assessment set servicecaseid = '34194f81-2fa1-41dd-bf6e-389d5f87d668', updatedby = 'SSH233011', updatedon = '7/2/2009  3:56:12 PM' where assessmentid = '56a5112e-6f1e-4f41-bbd6-843b8f758de2' and activeflag = 1 ;
update cjams.assessment set servicecaseid = '34194f81-2fa1-41dd-bf6e-389d5f87d668', updatedby = 'SSH233011', updatedon = '12/4/2008  3:33:00 PM' where assessmentid = 'b1ef7b2f-7c05-4005-9942-455fa6329c1b' and activeflag = 1 ;
update cjams.assessment set servicecaseid = '34194f81-2fa1-41dd-bf6e-389d5f87d668', updatedby = 'MDE212311', updatedon = '1/31/2019  11:04:13 AM' where assessmentid = '3baf0385-3d1c-4b90-92e5-3bb7e8e843c0' and activeflag = 1 ;
update cjams.assessment set servicecaseid = '34194f81-2fa1-41dd-bf6e-389d5f87d668', updatedby = 'MDE212311', updatedon = '3/16/2017  10:04:40 AM' where assessmentid = '397c981b-9404-402f-bae0-28f6571d9a50' and activeflag = 1 ;
update cjams.assessment set servicecaseid = '34194f81-2fa1-41dd-bf6e-389d5f87d668', updatedby = 'MDE212311', updatedon = '1/16/2018  4:05:28 PM' where assessmentid = '1d44ef82-501b-434b-a7fa-7c9ceb64c23c' and activeflag = 1 ;
update cjams.assessment set servicecaseid = '34194f81-2fa1-41dd-bf6e-389d5f87d668', updatedby = 'MDE212311', updatedon = '11/1/2018  8:44:46 AM' where assessmentid = 'd974a6dd-c711-4b7d-9f64-b4d97668f97c' and activeflag = 1 ;
update cjams.assessment set servicecaseid = '34194f81-2fa1-41dd-bf6e-389d5f87d668', updatedby = 'MDE212311', updatedon = '7/28/2017  1:15:57 PM' where assessmentid = '1cfae685-a347-46a6-9c3d-a3fbe59aee56' and activeflag = 1 ;
update cjams.assessment set servicecaseid = '34194f81-2fa1-41dd-bf6e-389d5f87d668', updatedby = 'MDE212311', updatedon = '5/10/2019  9:58:21 AM' where assessmentid = '0a536a57-e84c-46d3-a980-8920d87150b1' and activeflag = 1 ;
update cjams.assessment set servicecaseid = '34194f81-2fa1-41dd-bf6e-389d5f87d668', updatedby = 'MDE212311', updatedon = '6/14/2017  2:24:37 PM' where assessmentid = '9c4073f8-8261-49f1-8060-b963ec130e50' and activeflag = 1 ;
update cjams.assessment set servicecaseid = '34194f81-2fa1-41dd-bf6e-389d5f87d668', updatedby = 'MDE212311', updatedon = '10/30/2017  2:36:33 PM' where assessmentid = '79e18e9c-4167-4bdd-b5f8-902a2823152b' and activeflag = 1 ;
update cjams.assessment set servicecaseid = '34194f81-2fa1-41dd-bf6e-389d5f87d668', updatedby = 'e22edb66-fce8-4b6c-8354-0ffe5e724d4a', updatedon = '8/2/2022  4:15:43 PM' where assessmentid = 'eb0ae15c-8a28-4b43-a99b-320aba721a91' and activeflag = 1 ;
update cjams.assessment set servicecaseid = '34194f81-2fa1-41dd-bf6e-389d5f87d668', updatedby = 'SSH233011', updatedon = '3/17/2009  2:12:58 PM' where assessmentid = 'a0c35f9a-2f45-49f9-aaf2-8268538037ac' and activeflag = 1 ;
update cjams.assessment set servicecaseid = '34194f81-2fa1-41dd-bf6e-389d5f87d668', updatedby = 'e22edb66-fce8-4b6c-8354-0ffe5e724d4a', updatedon = '7/5/2022  3:18:54 PM' where assessmentid = '08bf2a79-bd46-4005-ace2-abcc1a3f2bb2' and activeflag = 1 ;
update cjams.assessment set servicecaseid = '34194f81-2fa1-41dd-bf6e-389d5f87d668', updatedby = 'e22edb66-fce8-4b6c-8354-0ffe5e724d4a', updatedon = '8/3/2022  4:27:44 PM' where assessmentid = '0f7d57fd-a472-41ce-bff5-c2512172bced' and activeflag = 1 ;

