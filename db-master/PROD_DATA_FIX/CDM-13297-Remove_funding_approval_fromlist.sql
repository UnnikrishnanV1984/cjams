
-- Totally 16records are there. Keeping 4 records and removing the remaining records
-- 39, 42, 44 with active flag as 0 
-- 43 with active flag as 1
delete from routing where routingid in ('b263113b-ea80-4d7c-99eb-305e450079f6', 
'529bf5f3-dcbd-446e-b650-ce63bf1da500',
'ccb05df3-6381-455e-8ba3-31a9b7ce2881',
'91cb4d40-3bfe-4e36-bb2e-709c25dc128d',
'4d6a6dcb-bba8-4e22-93e1-b52fda5cc58b',
'3aeaf7d7-844d-4b23-982a-019146b37d0f',
'5fa7ac43-b56e-49c1-9391-18d5e576789b',
'bb477861-2d3b-41fa-92e1-471b51227ada',
'9726fd59-b93f-4a60-a155-6dafcb8852a5',
'46687040-168c-4bb9-b74b-7db09c1f0e37',
'adb58e55-61a6-41da-ba48-4fe73934523c',
'4b30e2d8-b08c-4c3d-8803-55b6310acbc6');