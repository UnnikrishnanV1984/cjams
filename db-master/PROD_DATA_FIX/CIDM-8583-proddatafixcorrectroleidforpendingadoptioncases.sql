/*
   Issue Description: CIDM-8583
   Category/ Module  : Prod data fix to update adoption pending case
   Root cause:  CDM-17836
   Pull request# for code fix: Code fix has deployed as part of CDM-17836
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

UPDATE routing SET fromroleid='IVESP', toroleid='IVESV', updatedon=now(), updatedby = 'CIDM-8583'
WHERE routingid IN ('a6d3b894-45fa-4f2b-88eb-295439f5dc36',
'7a724349-7efa-49e4-afdd-783896b075b1',
'a8e4b33b-2a52-4178-a51f-efa01e787211',
'3d880c56-b55a-4f76-aa44-314dbc518d55',
'a71ccc39-0697-4e1c-af1a-c2f7dea5ba5b',
'27176bed-f742-4c4c-aff1-368d8f1f62da',
'8b899e26-4d66-4559-b960-250cc3f585a0',
'1d69464b-84e3-487b-b980-5fc36defb7e5',
'af8464ac-13d7-42ae-b58f-f9e5183da280',
'c25d7176-cdab-488c-8d49-0d2dd7a5a0af',
'f15320c9-3390-4ab6-87e6-574dfab3f3a0',
'32e75311-1367-43e8-85df-393bb2377eb6',
'289d6a31-b7c6-4635-9329-c88e5ae74d1c',
'e23aeaec-ddb9-44fc-b876-0b815e15cdc3',
'7275e609-7594-4261-8b09-327321e29ad9',
'84fef8e4-197b-4fc2-8c30-5081fda4a5d4',
'50e84f80-6b6a-4a43-bb88-e9ca345cfd07',
'46f27e66-cb5e-4565-a0dd-9f893110a240',
'b7e3b3c5-cbd3-4999-b802-43777e09ffc4',
'b377344d-489e-4f7e-8177-8de936bdcc8b',
'0819e6bb-9dd2-43b3-81a1-9bd099e3a3fd',
'fa06d39f-cdd6-49ae-ae00-c142e6feacbd',
'88196c6e-c635-40e7-a964-728e5d25ecb5',
'50158da1-9c5e-4304-a02c-1427ec3a79cd',
'12dcad7b-ada6-4c58-a4e8-127547eba3f0',
'8e385bc7-e557-4f9e-aef7-2c6127f0a71b',
'2ff405f2-3651-4e82-86bc-223f67bbdb0c',
'77d9c4de-6774-4aeb-a2fe-8709c141693d',
'def54cad-5180-4f01-8894-43745d39e72c',
'39242906-a392-4ba0-9d68-c02f1ceffb15',
'd011459f-119f-4076-858d-4f87f276fdd6',
'7e676cd9-5fdf-4876-9a56-5983749b01cb',
'8487d2dd-6b68-4f75-9843-3f304bef8d4d',
'ce3bc6c7-2a97-4461-b57d-34926eed1ce4',
'2863dffa-150e-424a-8ae9-f462369244d8',
'5b17a8dd-3817-4c4f-8770-3b9a7e0a0896',
'9a39e05e-a630-4bb6-be11-e1e04e5a8ff0',
'10f7924a-be23-47f9-aa41-d571118c24f6',
'fd4149b1-9bfc-4916-a42c-14e949f1a902',
'598c3411-008f-4906-999b-59b2c925e9bd',
'6df1203d-8dc0-4c67-8b37-018ae856c7bb',
'6c978d4b-43b9-4383-89ea-220c8c619f86',
'3fd6f0da-f3a6-4bf2-a6ce-e1470a9dd0aa',
'f68ef436-19a1-4b2c-b2bc-d57931955842',
'08896563-7a1c-4a21-9f24-a8b21c250fdb',
'c94c3df8-70d5-4f41-b076-3b2eb56b8393',
'6b32c9ac-d34a-4028-ba3b-3c778712bb17',
'c9d00c7a-1334-4114-a0f3-a843e174a71d',
'f49e2bcb-2c60-4cb4-b04f-16baade2f7b1',
'4d8ffe10-86e4-4553-82a2-9c766d44c4f5',
'965989ee-12bb-4b00-97be-c7d63ede595b',
'5341b3a3-1d7e-4d35-adb9-987af4509729',
'39a6e190-53e0-477a-8803-9a827c20312f',
'256e43af-86b2-48ac-acc3-ce510563478e',
'19ff1bcd-95b8-4105-bbc5-2479cfc1bf18',
'e4ca017b-df34-4cb4-9912-ba7b753bc1b3',
'15411e5c-b391-49dc-a2fd-e3f9f5b3ceba',
'594e8d03-505a-4f68-be11-5060e2b2fa0b',
'cbd690d8-3567-461f-a9d3-d177781cbfc6',
'99884cef-314e-4a0b-9585-d1f17275f232',
'17c329ec-bc91-44c2-9f0c-6529232cdb2b',
'8f0173f8-12cc-4857-bbfc-f362aca1368b',
'8086dfaf-f40b-4976-bdc8-d14b49e28282',
'11fcf87d-e2ae-41b9-8340-c9fd2653b61c',
'28fbc026-f01f-4960-9276-aa181093aa75',
'6f6ef352-0649-4105-930f-e53dbea784ef',
'b9f01174-c4da-4ecb-a623-00980af0bea3',
'f9fc61d6-0a3b-4a49-95ed-6f399a2d55c5',
'1d350235-8f64-4f8e-9445-9a3fec4989b0',
'7f202a51-37f4-4f31-bca3-b257ccc213a8',
'b447f19f-a76a-4a3b-99b0-0043e48f67d4',
'48b78450-455b-43f3-8a98-f12e35864f3e',
'15d807e8-8559-4539-ae3f-aad5d2e2487b',
'd189e8d5-4ba2-42f2-a1ec-f725a14bf38d',
'fb531aa9-29af-4977-8faa-88173ecfa051',
'8eddbeef-7369-4119-a24c-55acbe68d28c',
'2624272c-3186-4d9e-bbb5-d865fa5b841f',
'aa97afc0-00fd-4718-ad2a-538a68015a91',
'5c054d8b-7b89-4916-90d9-e7d5077294ce',
'f9f28935-b5a6-4df7-9b50-0c42d3d068c2',
'dbda441f-3ee1-4993-81d6-078e81121038',
'482b96b4-82c4-4e9c-ad07-414b1b74f4a0',
'8a9bcea0-2e7e-42d7-91d0-2deb6bcc1572',
'5220d085-1d49-4901-8a17-173147647268',
'9db62d6e-37fe-47c9-bf35-e8f42d2a932e',
'8d95409d-3d64-4b0e-8087-3ca85d65bbda',
'bd5b020a-de7a-4b3f-bec2-17effef09e1e',
'51edd8e0-bfa9-47d6-b081-ae4ee989c475',
'bc1d9639-956f-451b-8917-f56d87344bbb',
'07cc27fd-6a52-4cc5-9b5a-6157c81159f5',
'639add46-3ac7-46db-9dca-012bed09c364',
'3df702d9-4142-4a71-89a1-d2bdd829a045') and activeflag = 1 and routingstatustypeid = 68 and eventcode = 'ABLR';






-- back up
-- UPDATE cjams.routing
-- SET fromroleid='IVESV', toroleid='IVESP', updatedon='2023-02-13 15:07:37.563'
-- WHERE routingid='a6d3b894-45fa-4f2b-88eb-295439f5dc36';
-- UPDATE cjams.routing
-- SET fromroleid='IVESV', toroleid='IVESP', updatedon='2023-01-26 14:48:35.798'
-- WHERE routingid='7a724349-7efa-49e4-afdd-783896b075b1';
-- UPDATE cjams.routing
-- SET fromroleid='IVESV', toroleid='IVESP', updatedon='2022-12-14 12:20:12.382'
-- WHERE routingid='a8e4b33b-2a52-4178-a51f-efa01e787211';
-- UPDATE cjams.routing
-- SET fromroleid='IVESV', toroleid='IVESP', updatedon='2022-11-22 09:58:54.117'
-- WHERE routingid='3d880c56-b55a-4f76-aa44-314dbc518d55';
-- UPDATE cjams.routing
-- SET fromroleid='IVESV', toroleid='IVESP', updatedon='2022-09-30 11:15:33.226'
-- WHERE routingid='a71ccc39-0697-4e1c-af1a-c2f7dea5ba5b';
-- UPDATE cjams.routing
-- SET fromroleid='CWCW', toroleid='IVESP', updatedon='2022-08-29 13:12:57.291'
-- WHERE routingid='27176bed-f742-4c4c-aff1-368d8f1f62da';
-- UPDATE cjams.routing
-- SET fromroleid='CWCW', toroleid='IVESP', updatedon='2022-08-18 15:40:05.013'
-- WHERE routingid='8b899e26-4d66-4559-b960-250cc3f585a0';
-- UPDATE cjams.routing
-- SET fromroleid='CWCW', toroleid='IVESP', updatedon='2022-08-18 11:20:12.301'
-- WHERE routingid='1d69464b-84e3-487b-b980-5fc36defb7e5';
-- UPDATE cjams.routing
-- SET fromroleid='CWCW', toroleid='IVESP', updatedon='2022-08-15 14:19:47.581'
-- WHERE routingid='af8464ac-13d7-42ae-b58f-f9e5183da280';
-- UPDATE cjams.routing
-- SET fromroleid='IVESV', toroleid='IVESP', updatedon='2022-07-11 11:07:32.858'
-- WHERE routingid='c25d7176-cdab-488c-8d49-0d2dd7a5a0af';
-- UPDATE cjams.routing
-- SET fromroleid='IVESV', toroleid='IVESP', updatedon='2022-05-25 17:48:41.562'
-- WHERE routingid='f15320c9-3390-4ab6-87e6-574dfab3f3a0';
-- UPDATE cjams.routing
-- SET fromroleid='IVESV', toroleid='IVESP', updatedon='2022-05-02 16:06:15.455'
-- WHERE routingid='32e75311-1367-43e8-85df-393bb2377eb6';
-- UPDATE cjams.routing
-- SET fromroleid='IVESV', toroleid='IVESP', updatedon='2022-04-01 15:00:18.935'
-- WHERE routingid='289d6a31-b7c6-4635-9329-c88e5ae74d1c';
-- UPDATE cjams.routing
-- SET fromroleid='IVESV', toroleid='IVESP', updatedon='2022-02-23 10:53:24.563'
-- WHERE routingid='e23aeaec-ddb9-44fc-b876-0b815e15cdc3';
-- UPDATE cjams.routing
-- SET fromroleid='IVESV', toroleid='IVESP', updatedon='2022-01-04 10:47:21.683'
-- WHERE routingid='7275e609-7594-4261-8b09-327321e29ad9';
-- UPDATE cjams.routing
-- SET fromroleid='IVESV', toroleid='IVESP', updatedon='2021-12-16 14:44:47.927'
-- WHERE routingid='84fef8e4-197b-4fc2-8c30-5081fda4a5d4';
-- UPDATE cjams.routing
-- SET fromroleid='IVESV', toroleid='IVESP', updatedon='2021-07-07 15:41:09.799'
-- WHERE routingid='50e84f80-6b6a-4a43-bb88-e9ca345cfd07';
-- UPDATE cjams.routing
-- SET fromroleid='IVESV', toroleid='IVESP', updatedon='2021-06-17 14:50:14.958'
-- WHERE routingid='46f27e66-cb5e-4565-a0dd-9f893110a240';
-- UPDATE cjams.routing
-- SET fromroleid='IVESV', toroleid='IVESP', updatedon='2021-06-17 12:24:06.657'
-- WHERE routingid='b7e3b3c5-cbd3-4999-b802-43777e09ffc4';
-- UPDATE cjams.routing
-- SET fromroleid='FNSFS', toroleid='IVESP', updatedon='2021-04-27 13:33:56.767'
-- WHERE routingid='b377344d-489e-4f7e-8177-8de936bdcc8b';
-- UPDATE cjams.routing
-- SET fromroleid='FNSFS', toroleid='IVESP', updatedon='2021-04-27 13:27:37.208'
-- WHERE routingid='0819e6bb-9dd2-43b3-81a1-9bd099e3a3fd';
-- UPDATE cjams.routing
-- SET fromroleid='FNSFS', toroleid='IVESP', updatedon='2021-04-27 12:57:22.487'
-- WHERE routingid='fa06d39f-cdd6-49ae-ae00-c142e6feacbd';
-- UPDATE cjams.routing
-- SET fromroleid='FNSFS', toroleid='IVESP', updatedon='2021-04-27 12:43:05.674'
-- WHERE routingid='88196c6e-c635-40e7-a964-728e5d25ecb5';
-- UPDATE cjams.routing
-- SET fromroleid='FNSFS', toroleid='IVESP', updatedon='2021-04-27 11:25:25.928'
-- WHERE routingid='50158da1-9c5e-4304-a02c-1427ec3a79cd';
-- UPDATE cjams.routing
-- SET fromroleid='FNSFS', toroleid='IVESP', updatedon='2021-04-27 11:06:25.922'
-- WHERE routingid='12dcad7b-ada6-4c58-a4e8-127547eba3f0';
-- UPDATE cjams.routing
-- SET fromroleid='FNSFS', toroleid='IVESP', updatedon='2021-04-27 11:00:21.829'
-- WHERE routingid='8e385bc7-e557-4f9e-aef7-2c6127f0a71b';
-- UPDATE cjams.routing
-- SET fromroleid='FNSFS', toroleid='IVESP', updatedon='2021-04-27 11:00:18.880'
-- WHERE routingid='2ff405f2-3651-4e82-86bc-223f67bbdb0c';
-- UPDATE cjams.routing
-- SET fromroleid='FNSFS', toroleid='IVESP', updatedon='2021-04-27 10:53:03.481'
-- WHERE routingid='77d9c4de-6774-4aeb-a2fe-8709c141693d';
-- UPDATE cjams.routing
-- SET fromroleid='FNSFS', toroleid='IVESP', updatedon='2021-04-27 10:48:33.162'
-- WHERE routingid='def54cad-5180-4f01-8894-43745d39e72c';
-- UPDATE cjams.routing
-- SET fromroleid='FNSFS', toroleid='IVESP', updatedon='2021-04-27 10:46:17.993'
-- WHERE routingid='39242906-a392-4ba0-9d68-c02f1ceffb15';
-- UPDATE cjams.routing
-- SET fromroleid='FNSFS', toroleid='IVESP', updatedon='2021-04-26 16:33:57.582'
-- WHERE routingid='d011459f-119f-4076-858d-4f87f276fdd6';
-- UPDATE cjams.routing
-- SET fromroleid='FNSFS', toroleid='IVESP', updatedon='2021-04-26 16:20:26.148'
-- WHERE routingid='7e676cd9-5fdf-4876-9a56-5983749b01cb';
-- UPDATE cjams.routing
-- SET fromroleid='FNSFS', toroleid='IVESP', updatedon='2021-04-26 16:09:12.095'
-- WHERE routingid='8487d2dd-6b68-4f75-9843-3f304bef8d4d';
-- UPDATE cjams.routing
-- SET fromroleid='FNSFS', toroleid='IVESP', updatedon='2021-04-26 16:00:23.094'
-- WHERE routingid='ce3bc6c7-2a97-4461-b57d-34926eed1ce4';
-- UPDATE cjams.routing
-- SET fromroleid='FNSFS', toroleid='IVESP', updatedon='2021-04-26 15:50:40.660'
-- WHERE routingid='2863dffa-150e-424a-8ae9-f462369244d8';
-- UPDATE cjams.routing
-- SET fromroleid='FNSFS', toroleid='IVESP', updatedon='2021-04-26 15:43:51.541'
-- WHERE routingid='5b17a8dd-3817-4c4f-8770-3b9a7e0a0896';
-- UPDATE cjams.routing
-- SET fromroleid='FNSFS', toroleid='IVESP', updatedon='2021-04-26 15:24:13.730'
-- WHERE routingid='9a39e05e-a630-4bb6-be11-e1e04e5a8ff0';
-- UPDATE cjams.routing
-- SET fromroleid='FNSFS', toroleid='IVESP', updatedon='2021-04-26 15:20:17.271'
-- WHERE routingid='10f7924a-be23-47f9-aa41-d571118c24f6';
-- UPDATE cjams.routing
-- SET fromroleid='FNSFS', toroleid='IVESP', updatedon='2021-04-26 15:15:20.159'
-- WHERE routingid='fd4149b1-9bfc-4916-a42c-14e949f1a902';
-- UPDATE cjams.routing
-- SET fromroleid='FNSFS', toroleid='IVESP', updatedon='2021-04-01 14:20:56.846'
-- WHERE routingid='598c3411-008f-4906-999b-59b2c925e9bd';
-- UPDATE cjams.routing
-- SET fromroleid='FNSFS', toroleid='IVESP', updatedon='2021-04-01 14:12:58.056'
-- WHERE routingid='6df1203d-8dc0-4c67-8b37-018ae856c7bb';
-- UPDATE cjams.routing
-- SET fromroleid='FNSFS', toroleid='IVESP', updatedon='2021-04-01 14:08:25.054'
-- WHERE routingid='6c978d4b-43b9-4383-89ea-220c8c619f86';
-- UPDATE cjams.routing
-- SET fromroleid='FNSFS', toroleid='IVESP', updatedon='2021-04-01 13:33:58.814'
-- WHERE routingid='3fd6f0da-f3a6-4bf2-a6ce-e1470a9dd0aa';
-- UPDATE cjams.routing
-- SET fromroleid='FNSFS', toroleid='IVESP', updatedon='2021-04-01 13:19:58.404'
-- WHERE routingid='f68ef436-19a1-4b2c-b2bc-d57931955842';
-- UPDATE cjams.routing
-- SET fromroleid='FNSFS', toroleid='IVESP', updatedon='2021-04-01 13:13:19.207'
-- WHERE routingid='08896563-7a1c-4a21-9f24-a8b21c250fdb';
-- UPDATE cjams.routing
-- SET fromroleid='FNSFS', toroleid='IVESP', updatedon='2021-04-01 13:03:31.272'
-- WHERE routingid='c94c3df8-70d5-4f41-b076-3b2eb56b8393';
-- UPDATE cjams.routing
-- SET fromroleid='FNSFS', toroleid='IVESP', updatedon='2021-04-01 12:42:45.548'
-- WHERE routingid='6b32c9ac-d34a-4028-ba3b-3c778712bb17';
-- UPDATE cjams.routing
-- SET fromroleid='FNSFS', toroleid='IVESP', updatedon='2021-04-01 12:18:34.117'
-- WHERE routingid='c9d00c7a-1334-4114-a0f3-a843e174a71d';
-- UPDATE cjams.routing
-- SET fromroleid='FNSFS', toroleid='IVESP', updatedon='2021-03-29 14:59:22.243'
-- WHERE routingid='f49e2bcb-2c60-4cb4-b04f-16baade2f7b1';
-- UPDATE cjams.routing
-- SET fromroleid='FNSFS', toroleid='IVESP', updatedon='2021-03-19 10:37:00.779'
-- WHERE routingid='4d8ffe10-86e4-4553-82a2-9c766d44c4f5';
-- UPDATE cjams.routing
-- SET fromroleid='FNSFS', toroleid='IVESP', updatedon='2021-03-18 16:07:49.320'
-- WHERE routingid='965989ee-12bb-4b00-97be-c7d63ede595b';
-- UPDATE cjams.routing
-- SET fromroleid='FNSFS', toroleid='IVESP', updatedon='2021-03-18 16:01:38.715'
-- WHERE routingid='5341b3a3-1d7e-4d35-adb9-987af4509729';
-- UPDATE cjams.routing
-- SET fromroleid='FNSFS', toroleid='IVESP', updatedon='2021-03-18 15:53:25.816'
-- WHERE routingid='39a6e190-53e0-477a-8803-9a827c20312f';
-- UPDATE cjams.routing
-- SET fromroleid='FNSFS', toroleid='IVESP', updatedon='2021-03-18 15:33:50.890'
-- WHERE routingid='256e43af-86b2-48ac-acc3-ce510563478e';
-- UPDATE cjams.routing
-- SET fromroleid='FNSFS', toroleid='IVESP', updatedon='2021-03-18 15:20:59.542'
-- WHERE routingid='19ff1bcd-95b8-4105-bbc5-2479cfc1bf18';
-- UPDATE cjams.routing
-- SET fromroleid='FNSFS', toroleid='IVESP', updatedon='2021-03-18 15:08:46.391'
-- WHERE routingid='e4ca017b-df34-4cb4-9912-ba7b753bc1b3';
-- UPDATE cjams.routing
-- SET fromroleid='FNSFS', toroleid='IVESP', updatedon='2021-03-18 15:02:52.745'
-- WHERE routingid='15411e5c-b391-49dc-a2fd-e3f9f5b3ceba';
-- UPDATE cjams.routing
-- SET fromroleid='FNSFS', toroleid='IVESP', updatedon='2021-03-18 14:55:26.281'
-- WHERE routingid='594e8d03-505a-4f68-be11-5060e2b2fa0b';
-- UPDATE cjams.routing
-- SET fromroleid='FNSFS', toroleid='IVESP', updatedon='2021-03-05 14:11:58.020'
-- WHERE routingid='cbd690d8-3567-461f-a9d3-d177781cbfc6';
-- UPDATE cjams.routing
-- SET fromroleid='FNSFS', toroleid='IVESP', updatedon='2021-03-05 13:58:17.801'
-- WHERE routingid='99884cef-314e-4a0b-9585-d1f17275f232';
-- UPDATE cjams.routing
-- SET fromroleid='FNSFS', toroleid='IVESP', updatedon='2021-03-05 13:47:20.223'
-- WHERE routingid='17c329ec-bc91-44c2-9f0c-6529232cdb2b';
-- UPDATE cjams.routing
-- SET fromroleid='FNSFS', toroleid='IVESP', updatedon='2021-03-05 13:41:48.002'
-- WHERE routingid='8f0173f8-12cc-4857-bbfc-f362aca1368b';
-- UPDATE cjams.routing
-- SET fromroleid='FNSFS', toroleid='IVESP', updatedon='2021-03-05 13:31:36.698'
-- WHERE routingid='8086dfaf-f40b-4976-bdc8-d14b49e28282';
-- UPDATE cjams.routing
-- SET fromroleid='FNSFS', toroleid='IVESP', updatedon='2021-03-05 13:22:53.582'
-- WHERE routingid='11fcf87d-e2ae-41b9-8340-c9fd2653b61c';
-- UPDATE cjams.routing
-- SET fromroleid='FNSFS', toroleid='IVESP', updatedon='2021-03-05 13:18:38.969'
-- WHERE routingid='28fbc026-f01f-4960-9276-aa181093aa75';
-- UPDATE cjams.routing
-- SET fromroleid='FNSFS', toroleid='IVESP', updatedon='2021-03-05 13:07:29.204'
-- WHERE routingid='6f6ef352-0649-4105-930f-e53dbea784ef';
-- UPDATE cjams.routing
-- SET fromroleid='FNSFS', toroleid='IVESP', updatedon='2021-03-05 12:58:58.457'
-- WHERE routingid='b9f01174-c4da-4ecb-a623-00980af0bea3';
-- UPDATE cjams.routing
-- SET fromroleid='FNSFS', toroleid='IVESP', updatedon='2021-03-05 12:52:45.287'
-- WHERE routingid='f9fc61d6-0a3b-4a49-95ed-6f399a2d55c5';
-- UPDATE cjams.routing
-- SET fromroleid='FNSFS', toroleid='IVESP', updatedon='2021-03-05 11:12:44.114'
-- WHERE routingid='1d350235-8f64-4f8e-9445-9a3fec4989b0';
-- UPDATE cjams.routing
-- SET fromroleid='FNSFS', toroleid='IVESP', updatedon='2021-03-05 10:58:04.246'
-- WHERE routingid='7f202a51-37f4-4f31-bca3-b257ccc213a8';
-- UPDATE cjams.routing
-- SET fromroleid='FNSFS', toroleid='IVESP', updatedon='2021-03-01 14:30:38.622'
-- WHERE routingid='b447f19f-a76a-4a3b-99b0-0043e48f67d4';
-- UPDATE cjams.routing
-- SET fromroleid='FNSFS', toroleid='IVESP', updatedon='2021-03-01 14:15:47.705'
-- WHERE routingid='48b78450-455b-43f3-8a98-f12e35864f3e';
-- UPDATE cjams.routing
-- SET fromroleid='FNSFS', toroleid='IVESP', updatedon='2021-03-01 14:08:43.632'
-- WHERE routingid='15d807e8-8559-4539-ae3f-aad5d2e2487b';
-- UPDATE cjams.routing
-- SET fromroleid='FNSFS', toroleid='IVESP', updatedon='2021-03-01 12:46:08.744'
-- WHERE routingid='d189e8d5-4ba2-42f2-a1ec-f725a14bf38d';
-- UPDATE cjams.routing
-- SET fromroleid='FNSFS', toroleid='IVESP', updatedon='2021-03-01 12:30:42.309'
-- WHERE routingid='fb531aa9-29af-4977-8faa-88173ecfa051';
-- UPDATE cjams.routing
-- SET fromroleid='FNSFS', toroleid='IVESP', updatedon='2021-03-01 12:00:41.279'
-- WHERE routingid='8eddbeef-7369-4119-a24c-55acbe68d28c';
-- UPDATE cjams.routing
-- SET fromroleid='FNSFS', toroleid='IVESP', updatedon='2021-03-01 11:46:32.874'
-- WHERE routingid='2624272c-3186-4d9e-bbb5-d865fa5b841f';
-- UPDATE cjams.routing
-- SET fromroleid='FNSFS', toroleid='IVESP', updatedon='2021-03-01 11:25:39.385'
-- WHERE routingid='aa97afc0-00fd-4718-ad2a-538a68015a91';
-- UPDATE cjams.routing
-- SET fromroleid='FNSFS', toroleid='IVESP', updatedon='2021-02-26 16:27:06.689'
-- WHERE routingid='5c054d8b-7b89-4916-90d9-e7d5077294ce';
-- UPDATE cjams.routing
-- SET fromroleid='FNSFS', toroleid='IVESP', updatedon='2021-02-26 16:21:56.529'
-- WHERE routingid='f9f28935-b5a6-4df7-9b50-0c42d3d068c2';
-- UPDATE cjams.routing
-- SET fromroleid='FNSFS', toroleid='IVESP', updatedon='2021-02-26 16:07:04.900'
-- WHERE routingid='dbda441f-3ee1-4993-81d6-078e81121038';
-- UPDATE cjams.routing
-- SET fromroleid='FNSFS', toroleid='IVESP', updatedon='2021-02-26 15:17:52.597'
-- WHERE routingid='482b96b4-82c4-4e9c-ad07-414b1b74f4a0';
-- UPDATE cjams.routing
-- SET fromroleid='FNSFS', toroleid='IVESP', updatedon='2021-01-20 09:32:16.161'
-- WHERE routingid='8a9bcea0-2e7e-42d7-91d0-2deb6bcc1572';
-- UPDATE cjams.routing
-- SET fromroleid='FNSFS', toroleid='IVESP', updatedon='2021-01-15 13:12:35.988'
-- WHERE routingid='5220d085-1d49-4901-8a17-173147647268';
-- UPDATE cjams.routing
-- SET fromroleid='FNSFS', toroleid='IVESP', updatedon='2021-01-15 11:58:22.117'
-- WHERE routingid='9db62d6e-37fe-47c9-bf35-e8f42d2a932e';
-- UPDATE cjams.routing
-- SET fromroleid='FNSFS', toroleid='IVESP', updatedon='2021-01-15 11:58:15.337'
-- WHERE routingid='8d95409d-3d64-4b0e-8087-3ca85d65bbda';
-- UPDATE cjams.routing
-- SET fromroleid='FNSFS', toroleid='IVESP', updatedon='2020-12-02 16:26:37.768'
-- WHERE routingid='bd5b020a-de7a-4b3f-bec2-17effef09e1e';
-- UPDATE cjams.routing
-- SET fromroleid='FNSFS', toroleid='IVESP', updatedon='2020-12-02 15:58:53.184'
-- WHERE routingid='51edd8e0-bfa9-47d6-b081-ae4ee989c475';
-- UPDATE cjams.routing
-- SET fromroleid='FNSFS', toroleid='IVESP', updatedon='2020-11-06 16:18:47.468'
-- WHERE routingid='bc1d9639-956f-451b-8917-f56d87344bbb';
-- UPDATE cjams.routing
-- SET fromroleid='FNSFS', toroleid='IVESP', updatedon='2020-10-29 12:53:31.433'
-- WHERE routingid='07cc27fd-6a52-4cc5-9b5a-6157c81159f5';
-- UPDATE cjams.routing
-- SET fromroleid='IVESV', toroleid='IVESP', updatedon='2020-10-27 14:35:58.889'
-- WHERE routingid='639add46-3ac7-46db-9dca-012bed09c364';
-- UPDATE cjams.routing
-- SET fromroleid='IVESV', toroleid='IVESP', updatedon='2020-10-27 13:15:14.824'
-- WHERE routingid='3df702d9-4142-4a71-89a1-d2bdd829a045';

