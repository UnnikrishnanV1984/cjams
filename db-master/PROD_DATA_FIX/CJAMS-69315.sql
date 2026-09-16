/*
Issue: Program Manager's Approval Box - Service Logs
Root cause: Not a defect ,Requested to reassign the Purchase Authorizations Amesha Smith's individually assigned service logs from her individual Program Manager Approval Box to the Role Based Program Manager Approval Box so all Program mangers  will be able to approved it.
Fix provided: Data fix has been done to reassign the Purchase Authorizations to Role Based Program Manager Approval Box
Data/Code fix ticket#: CJAMS-69315
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support
*/
update routing set eventcode = 'PCAUTHR',tosecurityusersid = null, updatedby='CJAMS-69315',updatedon=now()
where routingid in ('f717ba8c-3f35-4621-978a-56c16ff92cef',
'04bc502b-a6aa-44d0-ab52-1eed0ff1a24a',
'7791406d-90ca-450a-a472-f3d0cee9929d',
'ee47eede-cdcb-4369-b43b-5b9603621ba5',
'3b984250-c6af-4d30-bad7-522b99ae8746',
'813f8143-f41b-466b-b744-133417903ea4',
'99559859-7e56-4799-b751-a431d80a7513',
'9eb6cf8b-efde-42bc-a7fd-0f0435d38628',
'490e47f5-eff4-44a6-ba4f-9aece43ae042',
'676202ef-83e9-413d-af2a-2639fa11d8ca',
'8853d96a-1e05-4923-9c67-233c485c7138',
'0b53a5ac-5fd6-42f6-9927-8c4648be8a3d',
'ddb7afa9-97b8-4833-9d0b-eb7e30c9f0c5',
'763ff982-85eb-4c4a-949f-b0a4fe337d1e',
'9faca8dc-7b22-43b8-98c3-84f962696630',
'64a1cccc-14ca-4c9d-bff5-fc80e5c2f367',
'33364426-fccc-4841-b558-2c2c2541fd4f',
'a2799ffb-110c-45e7-8c75-c5665c11d3c8',
'a1a5d050-2ba7-4c42-b28c-2365ce000df7',
'ce90a6b6-d65d-4cb9-95a4-3805465819d7',
'5d57ae3d-9749-44f4-8afd-2bf603554ca6',
'6a4b8c63-0fae-4e9d-ba71-c9a97f28d735',
'300827a8-0e72-460e-b836-68752970801d',
'b8df51be-ee13-4b49-92f0-6792c534c0ff',
'8aec847f-c2ed-4f1c-9283-e6f5aee9557c',
'4d2722ad-3a0b-45d3-86d4-32b63646d89a',
'9912f498-75e3-4229-bb02-52b18971b02e',
'c6b578a1-bfef-45ff-ae33-6fe08885ea63',
'6fa1c877-d2b4-4a49-b62b-264872f6254c',
'cdaf368e-7267-4cd6-8570-dd78a1373b32',
'ad534c8a-cdcd-4c1a-85ca-068813158cf1',
'2d9f19bb-404a-48f4-9040-0753b1285a35',
'a6d4761f-36bc-4855-b4e8-a38ebe4ed5b8',
'9dac3796-a566-444e-88f8-f6edcf7ebdd8',
'2d1d82ff-972d-42d2-9d3c-fbdcd01e3449',
'e4a81708-223f-42b0-a90f-6cd6dee59706',
'27b0ab87-adfa-44f1-8aad-388ef8e256d8',
'b054f603-3750-4a70-979f-4bf714b57f62',
'e12b3409-28ab-428c-b7f9-ecb7e05a4b29',
'2c5ae7a2-b17a-46ab-a69c-7fe6084e82b2',
'0238f873-788e-4b5d-95f7-31a2d4627b6b',
'5d02b3ed-90d2-41dc-8e29-f0b91883ebe3',
'5b0d149a-36ee-4a89-8099-75dc9f5678db',
'c289318d-09a0-4fe0-a848-a5c34eec4840',
'032a79fd-0ca8-4aa2-b4a0-f799b1ef5892',
'979504ef-73b4-4273-bf51-351809e0fce4') and toroleid='LDSSPM' and activeflag=1;
