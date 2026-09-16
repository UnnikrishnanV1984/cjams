



/*
Issue Description:241030423128:A. Smith cjams# 202873618 - I've tried to delete the image and they have upload but when I try to upload new pics it will not allow. When I try to delete the dups they reappear
Root cause: User do not have acces delete draft file in documents uploaded.
Fix provided: DB query to documentproperties table.
Data/Code fix ticket#: CJAMS-58393
Regression Impacts: N/A
Is Code fix Required?: No 
Code fix ticket#: N/A
Reason why no related code fix: User Error, it is data related issue not functional issue.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/
 update  documentproperties
 set activeflag =0, updatedby = 'CJAMS-59961', updatedon = now()
 where documentpropertiesid in ('a92b4bfb-7190-4feb-a4d8-d0ae891dd174',
'09451116-2595-4131-9f47-9fc0e6b0d980',
'2300b96c-883c-4dc4-bbba-65400d3b4a68',
'fc8d1faf-ca44-4f7b-846b-cea07566cc87',
'b5800146-9f4c-4afa-8611-cdeef2d8bfd5',
'afe25101-8d67-4c47-9327-3658354cd01e',
'b5545c66-bbcd-4b89-9155-731d90b0dd96',
'12d65c47-9104-4d40-9903-1943e324c616',
'ab0b6a5c-cf93-47c2-a534-647e7d5288a7',
'bbf58209-6925-46df-9183-007e9d7f4a98',
'629224c3-7a8f-42e4-b909-9e27e80ba265',
'33bcc650-03b1-4b6a-9fc6-50813e3c58f1',
'961f0edd-cb6e-4af1-9f4e-05e646d231c0',
'12c8abb5-ad17-47aa-945a-9be249de0971',
'eb230694-a674-4e68-a5dd-66ab101d9561',
'd758db3c-f5e1-41ec-8d40-620956d66a81',
'bdd1dd67-157b-4cdb-850a-91108f3bf032',
'36542815-5997-4acc-a4d5-e9bde669bc65',
'ad3326af-289f-4f23-a175-8f613fd9766e',
'34763add-5fe8-4d74-b126-30cd43a6fd8d',
'0f9f8700-4fcc-4714-a33f-bb41d6c1ab40',
'4689f7e8-2aaf-43cb-ba39-ac4d8863e84a',
'e02fe3f0-45f7-41c4-978b-26cef5bfd3e7',
'3ced89aa-14bb-4567-9784-f621838bb83a',
'c3510ccf-cbc8-43db-8232-770beb5e5334',
'56040e1f-6912-4a17-8a6c-a7e6bcd08ccf',
'9ed1ee7f-d6e1-44fc-8536-6dbe2e62653d',
'17ecb273-39ea-4e36-839f-112558323688',
'094ddae5-2bfb-4835-8df9-2b8a61ae8c16',
'60f371e2-da8b-4b01-9aa9-79247ead0b0f',
'20bd11a5-367c-4d1d-8bd6-a02440b8b39a',
'550308c1-b5ac-40a3-8ff5-b768064aeb76',
'c659c550-501f-40f2-ae2f-0258b20ab9b7',
'46f91100-6e0f-44b2-9b6d-5efac5298514',
'd6b15f9c-bf54-4540-9df2-8691c6f56ac6',
'a9316e33-a78c-41e7-826d-b28e8bdbf675',
'15d7cdd0-29c0-48e6-8fcf-1002667ea318',
'da061b7f-b3e3-4273-aa9e-bd21146043c4',
'a7c9aa74-68cf-4f23-9b89-84c5f2b37641',
'12e4fb61-eef9-485c-a463-6431d8adf1f2',
'f4932844-cbfd-4201-9b9f-018e930c0298',
'204aee07-66ca-4a2b-ac3e-b79b99bc0239',
'48c7e499-2f2d-4326-af11-c4f4e71ab755',
'56c1fa7a-fd12-4244-a469-1cbd7d16303f',
'58116eca-a7b6-4fec-a7b7-b2eaaa568b1b',
'2bbf9e9b-bc4a-4606-aebf-1b96b8617377',
'0be1bb94-a5bb-4af7-97c8-239304f308e3',
'2b9e6b55-1139-4056-9aee-a59d3667d91b',
'8178827a-1be0-4ac7-b38d-42d42c796ca6',
'7db51157-ae60-4a6c-ab88-be38900bc139',
'da506417-6a5c-4f2d-87b9-7d6573e0768c',
'd0d501b9-7915-4e83-a362-2b48bf40fd9c',
'8c893bb9-e3fa-40f6-bf0d-2b9f69520bd6',
'ad1724cd-c96e-4911-84be-5f14eee5df79',
'7a350198-9a5a-4b32-a180-6aad5daa85c1',
'18b4a171-e908-4e9d-82ee-6b388db18363',
'e5137ab3-69ee-414c-aa22-d018e1c8bf1b',
'81f7d0b8-d3a7-41c2-b5fc-36d879d65b0e',
'd0e9ec9e-f5ee-4582-977f-fc21724016ee',
'd4de23b9-2a17-48ba-a1fd-581089307757',
'd14c0909-2ee8-44a7-a92b-aaadce3fd10d',
'9e413ecb-7dce-4c85-896f-cb851699d546',
'af31788a-5f45-48de-a34a-fd87a466e362',
'8d1d7cfd-0c29-49a5-8239-30408089ca3e',
'11aab99a-c929-4f26-b06e-0278d00e01aa',
'960cfb61-8872-4707-935d-b6a7aa314626',
'3d04ff63-e5b0-4d62-a266-3384ad0645ac',
'bbc226c6-a11c-4036-9747-77a7b5fe62a4',
'f05cc5a4-44f5-44e4-9f7e-d35de6d696ad',
'4eb78fdb-4b4f-49dd-afa3-4a80654495d9',
'f2ddda5c-44fe-4df4-bf20-c1720dd7049f') and  activeflag =2;
