-- CDM-18317 - GAP Rate Approval Issue - Bulk fix
/*
-- Issue Description:
   Supervisor not able to approve the new GAP rates, stuck in Review Status. 
	
-- Category/ Module: Guardianship Assistance Program  (Case Management) 
-- Root cause: Code Deployed Issue; was fixed & deployed on Prod 10/22
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

/*
-- Case ID: 3160124
-- Client ID: 2218578 (DANIEL FAIRBANKS)
-- GAP ID: 952 - acd42cfc-6b40-4b97-a308-de7991f414ed
-- Provider ID: 5034197
-- GAP Agreement ID: 87a5b916-90d6-4654-a61f-7cb48a833b1e 
-- gapagreementrateid: 746bc5eb-427d-44a3-9524-2772b8695573

-- Case ID: 3189630
-- Client ID: 3111655 (SHAMAR TYWON LEWIS)
-- GAP ID: 3897 - b8a4fd2e-8d0d-40d0-8588-ad9d1d2fb823
-- Provider ID: 5061029
-- GAP Agreement ID:  036cf69e-2712-4370-aa1b-6bcfd5d8b123
-- gapagreementrateid: 1c5c3dcb-1dde-49e9-aef9-8ce97af6b88a

-- Case ID: 3104966	
-- Client ID: 3352629 (PRECIOUS BURRELL)
-- GAP ID: 3075 - b1ece585-f719-4de3-93a4-4301ff16fe86
-- Provider ID: 5062038
-- GAP Agreement ID: 0b47ae39-570a-407b-95f9-dd82f12ab4ea   
-- gapagreementrateid: 11e4de44-5c5a-4873-90c3-805b3b670f07

-- Case ID: 3183017
-- Client ID: 2849192 (KAYLIE N PANHOLZER) 
-- GAP ID: 4678 - 4b06b633-833f-4602-9584-0fbc5b673821
-- Provider ID: 5084583
-- GAP Agreement ID: 42080309-c6d2-4420-ab61-72940df7872a 
-- gapagreementrateid: b5c90090-f1bc-486c-992c-7d6b1ba346fa

-- Case ID: 3124937
-- Client ID: 1738270 (JALEN E HILL)
-- GAP ID: 869 - 82d5e870-ffde-41dc-9f1c-661819822082
-- Provider ID: 5012059
-- GAP Agreement ID: 19ba3e24-b900-414c-b728-d260a87eae9b  
-- gapagreementrateid: 0a4692a2-49e7-4d96-8baa-f3225ce7e255

-- Case ID: 3153384
-- Client ID: 2732235 (BLASSOM WALFORD)
-- GAP ID: 1765	 - 5d3659e7-37c1-48af-960a-d6d3afb1365e	
-- Provider ID: 5043232	
-- GAP Agreement ID: 2bf3f021-c2f4-4a7a-bce1-8fc8778e38e8 
-- gapagreementrateid: f159e11a-7540-4cee-9943-02f2a30fc0c2

-- Case ID: 3194712 
-- Client ID: 1649878 (SHAQAJA M JOHNSON) 
-- GAP ID: 3594	- 4d67b665-5c0f-4132-97ea-57c5ccdbda8c
-- Provider ID: 5067920
-- GAP Agreement ID: 021f451a-4b0f-4681-bbcd-0e0430ebe7a6  
-- gapagreementrateid: 059df2f6-3ee1-4293-bb9e-f0561f43611f

-- Case ID: 3154842
-- Client ID: 1837005 (DESTINY STANSBURY) 
-- GAP ID: 1379	- ae3c9875-42a5-4415-988b-d685aff6d89a
-- Provider ID: 5027176
-- GAP Agreement ID: 4b619fb0-f1d6-49d3-be32-c7fa9bc5fc3c 
-- gapagreementrateid: b8a26d36-aeb0-47e3-837b-f2ea131947c0

-- Case ID: 3108658
-- Client ID: 1695388 (MARCUS WOODARD)
-- GAP ID: 1813	- 5c4fc3ae-a801-4df3-9189-26c140235f8f
-- Provider ID: 5013149
-- GAP Agreement ID: 6cfaf1d0-d647-4c78-b1fa-59c09b1fe304
-- gapagreementrateid: 0c38d116-b9a4-4ce5-9a9f-1d51b54d702f

-- Case ID: 3076192
-- Client ID: 2397356 (ROMAN WASSON)
-- GAP ID: 1510	- 7b6b31ff-e4eb-41a7-a750-d9d08344a9be
-- Provider ID: 5035064
-- GAP Agreement ID: 759f58ba-6fad-403a-befd-528ef417b12c 
-- gapagreementrateid: d2c683fc-9edf-43a3-8656-22d237294b2f

-- Case ID: 3254939
-- Client ID: 3432415 (KAREEM U ALDABBAGH) 
-- GAP ID: 4212	- c0f08368-2bd9-4cb7-b0c3-74707a64adfd
-- Provider ID: 5078483
-- GAP Agreement ID: 8138e71d-0e31-45de-a048-bec77bc0fe2d 
-- gapagreementrateid: d57150c4-4765-4be8-9eef-e5092e883a97

-- Case ID: 3242272
-- Client ID: 4193561 (TONIESHA XIMINES)
-- GAP ID: 1005552 - f8266b73-36e5-432b-9446-31cd2751d38c
-- Provider ID: 5042070
-- GAP Agreement ID: 9ff8e4cf-388c-4170-98f4-2517ee61b01b 
-- gapagreementrateid: 58c802a6-871e-4da3-a9c4-a5a00c02d23b

-- Case ID: 3254939
-- Client ID: 3444116 (ALIYAH ALDABBAGH)
-- GAP ID: 4211	- 4f7a5f03-7280-410a-8440-4ae2eab016c1
-- Provider ID: 5078483
-- GAP Agreement ID: a0563883-d20c-41ff-9675-66c14c9bb92b 
-- gapagreementrateid: a818d682-aafa-45e6-992d-a575f133666a

-- Case ID: 3125122
-- Client ID: 1707011 (MARCUS LOMAX)
-- GAP ID: 613	- 31dbc418-d906-4d42-b190-7dcfbe89579c
-- Provider ID: 5013003
-- GAP Agreement ID:  b96af82a-1f11-4eea-829a-e7ae978dffc0 
-- gapagreementrateid: f942578b-f6b1-444b-88ea-305b0604f536

-- Case ID: 3163246
-- Client ID: 3403811 (MELINA SOPHIA BANKS)
-- GAP ID: 4012	- 4f843317-9356-401d-bfe6-15e0fec9812c
-- Provider ID: 5066071
-- GAP Agreement ID: c2f10e53-7d77-43b0-b5ee-d8cecaf89eb9 
-- gapagreementrateid: c199b3dd-e458-4416-a4ef-63a2318ccd9c

-- Case ID: 3214222
-- Client ID: 3376488 (JASYAH JOHNSTON)
-- GAP ID: 3901	- 73e81f38-7865-4fe4-a92c-5ff9ae5b5be3
-- Provider ID: 5065129
-- GAP Agreement ID: cfb6c0ff-4045-4b59-9ffc-e7afe0cecc98 
-- gapagreementrateid: cef251f4-2d8a-45e2-b5fe-1a237d914584

-- Case ID: 3254294
-- Client ID: 3804696 (FREDERICK A MORRISON)
-- GAP ID: 4963	- 3f5acdbb-6849-4c2f-aae0-60553fcbf3cb
-- Provider ID: 5086008
-- GAP Agreement ID: d88d9028-b5b1-4c49-a965-11c97e1b8e0c  
-- gapagreementrateid: 32d06bcb-1043-4058-ac9a-6e80ce850b6b

-- Case ID: 3156830
-- Client ID: 1788704 (MATTHEW M MINAYA)
-- GAP ID: 1680	- 00c59a0c-b70e-4137-98de-6e5be4c125de
-- Provider ID: 5027079
-- GAP Agreement ID: f1f99be7-8765-4145-a06a-19df5d18c8dd 
-- gapagreementrateid: c4425055-cb1a-4782-a2c8-71c825a4eacc

-- Case ID: 3163246
-- Client ID: 2371686 (JULIEANNA MARIA BANKS)
-- GAP ID: 4282	- 813000f9-7808-43d3-8a13-b388dedad12e
-- Provider ID: 5066071
-- GAP Agreement ID: f5ab212a-1844-4c0c-888a-be6e78fcd59d   
-- gapagreementrateid: 94690321-2c9e-42e2-8a9e-7484e0baafaf

-- Case ID: 3215149
-- Client ID: 3394958 (KAMOURI RICH)
-- GAP ID: 3059	- 73fa2938-ae7b-483f-93a1-588b950e88db
-- Provider ID: 5059909
-- GAP Agreement ID: f7907081-7b9e-4eb3-a96a-d638bef99843  
-- gapagreementrateid: 78daebee-eb7a-43d7-ac0c-4119a802d285

-- Case ID: 3214314
-- Client ID: 3388486 (KA'NYA  FITZGERALD) 
-- GAP ID: 3030	- c1e67884-4920-4a52-9f07-37c6d7127260
-- Provider ID: 5058538
-- GAP Agreement ID: fd3475be-27ac-489c-b1ad-113cb6ea104d  
-- gapagreementrateid: dfdc1f8f-9947-4328-b516-73e2bd97b699

-- Case ID: 3115766
-- Client ID: 2712077 (MYKAH BREEDLOVEHOLLMAN)
-- GAP ID: 2719 - 74e89b76-e846-4c15-b176-2aece5ce425a
-- Provider ID: 5037880
-- GAP Agreement ID: fd3d7fb3-5544-495b-8872-538ecfe93843 
-- gapagreementrateid: c2009f8c-26ea-4b62-825a-0d29f1b61280

-- Case ID: 3183750
-- Client ID: 2939095 (COLIN DAUGHERTY)
-- GAP ID: 1951 - 90693c0d-e6e0-4c1f-95ad-d6d0cd2dd8a3
-- Provider ID: 5054201
-- GAP Agreement ID: ae8cdbb6-e681-4e69-b474-0184cd7f017f   
-- gapagreementrateid: 9a51e038-14bc-4adc-9ef7-30a7382fd57a

-- Case ID: 3159270
-- Client ID: 1987879 (ETHAN M LINTHICUM)
-- GAP ID: 989 - a555657d-bbac-45ed-ac27-07bf8b854a41
-- Provider ID: 5035781
-- GAP Agreement ID: 62180cc3-3115-4bb2-af70-fc0e3de4b35b
-- gapagreementrateid: 9b5df942-1253-4eed-ab66-a7b7187fedfe

-- Case ID: 3180861
-- Client ID: 1744024 (KAYLEIGH SHAY HALL)
-- GAP ID: 3161	- 10586f59-4391-4706-8370-e30e5f7b1d2f
-- Provider ID: 5035399
-- GAP Agreement ID: 4be2792b-f3fd-46e5-b013-f2add032a0d3  
-- gapagreementrateid: f0413d55-ef77-44fb-8ac4-4e4b549b702f

-- Case ID: 3200723
-- Client ID: 3094442 (BLAIR P HAYES)
-- GAP ID: 3946	- b688dc96-df1e-4ba8-b7b8-343c226c8afe
-- Provider ID: 5075907
-- GAP Agreement ID: caa60523-777b-4bc7-9dd4-0f3fd5ab15dc   
-- gapagreementrateid: db33b772-24ba-46ec-88c9-d549b91e6db9

-- Case ID: 3200723
-- Client ID: 3615768 (KATELYN MARIE HAYES)
-- GAP ID: 3996	- e79eb8ba-f571-4501-b799-252dffb629e4
-- Provider ID: 5075907
-- GAP Agreement ID:  a7d99874-eec3-473a-a9f2-b385cfe661ed
-- gapagreementrateid: ff088ef1-23e4-40a2-9859-4baf75b0f0a8

-- Case ID: 3261600
-- Client ID: 3888802 (NEVAEH EMILY ROBINSON) 
-- GAP ID: 5047	- 69c842e9-85e1-45dc-926e-bb222513a901
-- Provider ID: 5082570
-- GAP Agreement ID: 4659fa46-9881-4c3c-ac60-565a1d6ee3e5 
-- gapagreementrateid: a9740d4a-84d5-4001-bee4-e2f2f37aa33b

-- Case ID: 3200723
-- Client ID: 3615769 (BRIAN HAYES)
-- GAP ID:  4078 - cf60cab6-6478-48a5-a205-2b0d00114d1b
-- Provider ID: 5075907
-- GAP Agreement ID: addedd2b-0dac-4e7f-a586-0a8d9b6839b4  
-- gapagreementrateid: 4aaa4d6b-b693-4cf1-93d9-6a6c12939eed

-- Case ID: 3261600
-- Client ID: 4005536 (KAMYIAH ELIZABETH ROBINSON)
-- GAP ID: 5013 - e6eb3412-dfbf-4ed5-8c6a-b68f2b012fa6
-- Provider ID: 5086207
-- GAP Agreement ID: 554c1210-018f-4a5f-8855-0b12b8da81c9  
-- gapagreementrateid: 44f2e11e-8c6b-42eb-8435-85a19d47a8a6

-- Case ID: 3200723
-- Client ID: 3094443 (MADISON A HAYES)
-- GAP ID: 3998	- 9e15e9d4-92f6-4261-bf90-59fc38d0cd95
-- Provider ID: 5075907
-- GAP Agreement ID: c1dfc416-489f-4131-bb54-eb1f0efa9204  
-- gapagreementrateid: 66832cdd-cb61-4e10-84e4-20e024673241

-- Case ID: 3157716
-- Client ID: 2336121 (JAHEID ZAYVON DORSEY)
-- GAP ID: 1091	- e0160e29-56e7-47b0-ae66-af3e6f5057b7
-- Provider ID: 5095626
-- GAP Agreement ID: 1020e621-9c4e-4ad8-9c27-ce37b47f9074 
-- gapagreementrateid: cda35237-b540-442d-8726-2f54ddb50487

-- Case ID: 3157716
-- Client ID: 1332615 (ZAYON J DORSEY)
-- GAP ID: 1045	- e1edb4a0-f7d6-475a-adc6-9321095c6189
-- Provider ID: 5095626
-- GAP Agreement ID: 9dd8b3e4-e260-499a-9cd8-34b61a0594c7 
-- gapagreementrateid: 0c766229-8490-4a55-89d0-80b2c9555e62

-- Case ID: 3055658
-- Client ID: 2561448 (JANELLE VIRGINIA FREDERICKS)
-- GAP ID: 2006 - c4338e85-4100-43fb-b5d5-0f173c8f97af
-- Provider ID: 5051220
-- GAP Agreement ID:  59ad84d7-b520-4ec4-93de-ca4982eef30c 
-- gapagreementrateid: 2f9b42ae-2b8e-47ef-a637-2fd946143b5d

-- Case ID: 3050566
-- Client ID: 1310149 (TYLAR M DOWNS) 
-- GAP ID: 196 - e7251740-5e37-4371-b8f4-441b880ec6a1
-- Provider ID: 5005126
-- GAP Agreement ID:  5d1c5927-7235-434e-8fcc-33ff58f8cbd9 
-- gapagreementrateid: 1e5c5fc8-1c5a-4274-9855-938a2546a22b

-- Case ID: 3216867
-- Client ID: 3420711 (AUTUMN SIMUEL) 
-- GAP ID: 3209	- 241f0c88-6fd4-4bf5-8409-4decad5596b9
-- Provider ID: 5060397
-- GAP Agreement ID: 388a54f2-dd6e-4084-9a1c-64b70960be48  
-- gapagreementrateid: d7403ce7-f9fa-4dd6-86e6-73618568cfa6

-- Case ID: 3240141
-- Client ID: 3672877 (MASON WEAVER)
-- GAP ID: 4036	- 7460ea62-265d-4d44-920c-d20a63fd2dac
-- Provider ID: 5073852
-- GAP Agreement ID: 56bc90ca-2556-4f82-8057-642e6bc85409 
-- gapagreementrateid: d2536aec-de4f-44a8-b394-193e08125abe

-- Case ID: 3073610
-- Client ID: 3412238 (ZHARIA LYNCH)
-- GAP ID: 3156	- 34e66643-10d4-4454-96ab-1b56117c1865
-- Provider ID: 5060079
-- GAP Agreement ID: f4c9423c-b396-43ef-a23c-aa8089ad0e99  
-- gapagreementrateid: 3f851b9c-812f-4360-b4d8-48cc7989df6c

-- Case ID: 3218933
-- Client ID: 3558748 (DIONE J WILSON)
-- GAP ID: 3560 - 6a8e98bf-01da-4039-8dd4-dd53a7807423
-- Provider ID: 5069507
-- GAP Agreement ID: abf1b7fc-ec00-40b0-8b24-588dd6045af7  
-- gapagreementrateid: 9864c82a-a8c0-4f57-9814-f8fb0c259cfd

-- Case ID: 3240141
-- Client ID: 3672893 (MADELINE A WEAVER)
-- GAP ID: 4035 - 19fe66e8-c14a-4c2e-90a1-7ce4f64d5ed8
-- Provider ID: 5073852
-- GAP Agreement ID: 2d103f22-23d7-405e-84ed-41fb1b67dc5b  
-- gapagreementrateid: 51ddaea2-676d-4f2e-b57a-0a834c4026a9

-- Case ID: 3227184
-- Client ID: 3554410 (NICOLE I CRAIG)
-- GAP ID: 3977	- a2627407-6768-4bea-96bb-3c93a13dfbc7
-- Provider ID: 5065986
-- GAP Agreement ID:  0f6ceeb2-19d0-459c-b626-02c230c5cd83 
-- gapagreementrateid: 6bfaa396-ff54-4804-a416-bb0af6865254

-- Case ID: 3071440
-- Client ID: 3560181 (JENNIFER WILLIAMS)
-- GAP ID: 4660	- 2d1b7856-5fc3-4edb-81b4-a52b0f3c47c5
-- Provider ID: 5028986
-- GAP Agreement ID: 39b9c775-6214-4fea-ad10-bedc41780d07 
-- gapagreementrateid: 1e60d1bd-cdff-43d7-ada3-366243b1cf88

-- Case ID: 3027649
-- Client ID: 1125312 (DAKOTA B MCKNEELY)
-- GAP ID: 1883 - fc29a6cf-a90a-4e83-a799-555f088b0b9c
-- Provider ID: 5053389
-- GAP Agreement ID:  44518a25-b1f0-4f80-a8dc-d44febaac17f
-- gapagreementrateid: 3de89c4f-6701-4a4c-bfa1-5564b7e2ec20

-- Case ID: 3267546
-- Client ID: 2902907 (THAI D'NAHJ BRISCOE)
-- GAP ID: 4454 - 6ce2546c-caf2-4662-9b3e-ee647005c224
-- Provider ID: 5084182
-- GAP Agreement ID: f893b8e7-fd7a-417e-92b1-3a68694c09c5  
-- gapagreementrateid: cbceac74-dff4-4dcc-a897-ea89d1900711

-- Case ID: 3279737
-- Client ID: 3589079 (JOSHUA BARONE)
-- GAP ID: 1005713 - 41059bec-96e9-4b86-8fea-a32e6f8e0372
-- Provider ID: 6002050
-- GAP Agreement ID: 780e986d-aede-476f-a6a8-2653567ff82e   
-- gapagreementrateid: 07b33878-cde7-4cde-b7fd-3d11c14f1c7f

-- Case ID: 3174514
-- Client ID: 1324874 (BRIANNA N YOUNG)
-- GAP ID: 2538 - 2935ad04-7bbd-4605-b245-e8221c00885a
-- Provider ID: 5061331
-- GAP Agreement ID:  14ec0309-eea9-47d1-a127-2a7c9cfe7517 
-- gapagreementrateid: b307f509-ef25-4ff3-b87d-bb6b19523129

*/

-- Soft-delete GAP Rate in Review
select activeflag, startdate, enddate, rateapprovaldate, paymentamout, status , updatedby, updatedon 
	from gapagreementrate 
where gapagreementrateid
	in (	'746bc5eb-427d-44a3-9524-2772b8695573',
			'1c5c3dcb-1dde-49e9-aef9-8ce97af6b88a',
			'11e4de44-5c5a-4873-90c3-805b3b670f07',
			'b5c90090-f1bc-486c-992c-7d6b1ba346fa',
			'0a4692a2-49e7-4d96-8baa-f3225ce7e255',
			'f159e11a-7540-4cee-9943-02f2a30fc0c2',
			'059df2f6-3ee1-4293-bb9e-f0561f43611f',
			'b8a26d36-aeb0-47e3-837b-f2ea131947c0',
			'0c38d116-b9a4-4ce5-9a9f-1d51b54d702f',
			'd2c683fc-9edf-43a3-8656-22d237294b2f',
			'd57150c4-4765-4be8-9eef-e5092e883a97',
			'58c802a6-871e-4da3-a9c4-a5a00c02d23b',
			'a818d682-aafa-45e6-992d-a575f133666a',
			'f942578b-f6b1-444b-88ea-305b0604f536',
			'c199b3dd-e458-4416-a4ef-63a2318ccd9c',
			'cef251f4-2d8a-45e2-b5fe-1a237d914584',
			'32d06bcb-1043-4058-ac9a-6e80ce850b6b',
			'c4425055-cb1a-4782-a2c8-71c825a4eacc',
			'94690321-2c9e-42e2-8a9e-7484e0baafaf',
			'78daebee-eb7a-43d7-ac0c-4119a802d285',
			'dfdc1f8f-9947-4328-b516-73e2bd97b699',
			'c2009f8c-26ea-4b62-825a-0d29f1b61280',
			'9a51e038-14bc-4adc-9ef7-30a7382fd57a',
			'9b5df942-1253-4eed-ab66-a7b7187fedfe',
			'f0413d55-ef77-44fb-8ac4-4e4b549b702f',
			'db33b772-24ba-46ec-88c9-d549b91e6db9',
			'ff088ef1-23e4-40a2-9859-4baf75b0f0a8',
			'a9740d4a-84d5-4001-bee4-e2f2f37aa33b',
			'4aaa4d6b-b693-4cf1-93d9-6a6c12939eed',
			'44f2e11e-8c6b-42eb-8435-85a19d47a8a6',
			'66832cdd-cb61-4e10-84e4-20e024673241',
			'cda35237-b540-442d-8726-2f54ddb50487',
			'0c766229-8490-4a55-89d0-80b2c9555e62',
			'2f9b42ae-2b8e-47ef-a637-2fd946143b5d',
			'1e5c5fc8-1c5a-4274-9855-938a2546a22b',
			'd7403ce7-f9fa-4dd6-86e6-73618568cfa6',
			'd2536aec-de4f-44a8-b394-193e08125abe',
			'3f851b9c-812f-4360-b4d8-48cc7989df6c',
			'9864c82a-a8c0-4f57-9814-f8fb0c259cfd',
			'51ddaea2-676d-4f2e-b57a-0a834c4026a9',
			'6bfaa396-ff54-4804-a416-bb0af6865254',
			'1e60d1bd-cdff-43d7-ada3-366243b1cf88',
			'3de89c4f-6701-4a4c-bfa1-5564b7e2ec20',
			'cbceac74-dff4-4dcc-a897-ea89d1900711',
			'07b33878-cde7-4cde-b7fd-3d11c14f1c7f',
			'b307f509-ef25-4ff3-b87d-bb6b19523129'
		)
	and lower(status) = 'review' 
	and activeflag = 1 ;

update gapagreementrate 
set activeflag = 0,
	updatedby = 'CDM-18317',
	updatedon = now()
where gapagreementrateid
	in (	'746bc5eb-427d-44a3-9524-2772b8695573',
			'1c5c3dcb-1dde-49e9-aef9-8ce97af6b88a',
			'11e4de44-5c5a-4873-90c3-805b3b670f07',
			'b5c90090-f1bc-486c-992c-7d6b1ba346fa',
			'0a4692a2-49e7-4d96-8baa-f3225ce7e255',
			'f159e11a-7540-4cee-9943-02f2a30fc0c2',
			'059df2f6-3ee1-4293-bb9e-f0561f43611f',
			'b8a26d36-aeb0-47e3-837b-f2ea131947c0',
			'0c38d116-b9a4-4ce5-9a9f-1d51b54d702f',
			'd2c683fc-9edf-43a3-8656-22d237294b2f',
			'd57150c4-4765-4be8-9eef-e5092e883a97',
			'58c802a6-871e-4da3-a9c4-a5a00c02d23b',
			'a818d682-aafa-45e6-992d-a575f133666a',
			'f942578b-f6b1-444b-88ea-305b0604f536',
			'c199b3dd-e458-4416-a4ef-63a2318ccd9c',
			'cef251f4-2d8a-45e2-b5fe-1a237d914584',
			'32d06bcb-1043-4058-ac9a-6e80ce850b6b',
			'c4425055-cb1a-4782-a2c8-71c825a4eacc',
			'94690321-2c9e-42e2-8a9e-7484e0baafaf',
			'78daebee-eb7a-43d7-ac0c-4119a802d285',
			'dfdc1f8f-9947-4328-b516-73e2bd97b699',
			'c2009f8c-26ea-4b62-825a-0d29f1b61280',
			'9a51e038-14bc-4adc-9ef7-30a7382fd57a',
			'9b5df942-1253-4eed-ab66-a7b7187fedfe',
			'f0413d55-ef77-44fb-8ac4-4e4b549b702f',
			'db33b772-24ba-46ec-88c9-d549b91e6db9',
			'ff088ef1-23e4-40a2-9859-4baf75b0f0a8',
			'a9740d4a-84d5-4001-bee4-e2f2f37aa33b',
			'4aaa4d6b-b693-4cf1-93d9-6a6c12939eed',
			'44f2e11e-8c6b-42eb-8435-85a19d47a8a6',
			'66832cdd-cb61-4e10-84e4-20e024673241',
			'cda35237-b540-442d-8726-2f54ddb50487',
			'0c766229-8490-4a55-89d0-80b2c9555e62',
			'2f9b42ae-2b8e-47ef-a637-2fd946143b5d',
			'1e5c5fc8-1c5a-4274-9855-938a2546a22b',
			'd7403ce7-f9fa-4dd6-86e6-73618568cfa6',
			'd2536aec-de4f-44a8-b394-193e08125abe',
			'3f851b9c-812f-4360-b4d8-48cc7989df6c',
			'9864c82a-a8c0-4f57-9814-f8fb0c259cfd',
			'51ddaea2-676d-4f2e-b57a-0a834c4026a9',
			'6bfaa396-ff54-4804-a416-bb0af6865254',
			'1e60d1bd-cdff-43d7-ada3-366243b1cf88',
			'3de89c4f-6701-4a4c-bfa1-5564b7e2ec20',
			'cbceac74-dff4-4dcc-a897-ea89d1900711',
			'07b33878-cde7-4cde-b7fd-3d11c14f1c7f',
			'b307f509-ef25-4ff3-b87d-bb6b19523129'
		)
	and lower(status) = 'review' 
	and activeflag = 1 ;
	
