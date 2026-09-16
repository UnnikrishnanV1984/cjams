/*
  Issue Description: CDM-33462 stuck approval
   Category/ Module:  Approval Inbox
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

UPDATE cjams.routing
SET activeflag = 0, updatedby='CDM-33462', updatedon=now()
WHERE routingid in ('1171eaa8-013b-4057-883e-556a02e5e4cd','f651c1e7-5366-4235-afdd-c8278b1d10ca','f5107d35-1824-4d44-891c-588a2a9c261a',
'ac0aad70-ae94-45dd-835d-15c136a3710c','62b739c4-9e0f-4407-b08a-5d38c30ed009','25cc5693-738b-4e34-80bf-ce95996709e9',
'3c27720b-7b77-4651-8e54-894a64305a28','867baacd-f3f0-4c75-9b34-c72c863682ce','6bc6bdf8-9e2f-48f3-b8eb-326f0cc5bdec',
'ff4068ab-2615-4cb3-b93f-e536b36f4b37','a8156465-638f-45bd-83c5-02968239b09b','07aa84de-2ebc-4d30-97e3-4feae57f5b88',
'9629cdcc-a025-445e-8d11-839e202524f5','4d338af4-2307-4735-8b53-c2b697535876','02800128-6f88-49b6-b0a0-f65cfabb249e',
'1cd2f9e4-a7cd-4fae-abd6-a2cbd3e5479e','a368b6e4-be84-4360-835d-1ec66265ee33','5e7dc9c8-0c02-403d-9506-694c42ae37c1',
'e16df0c2-51f7-4a96-b3c2-fdf720e5a9c4','3b280345-0c16-4f79-bcd4-108201afcb29','4a85ab38-8f52-44d3-b505-078d4b7dbaa5',
'afef3bb3-36b4-4491-a390-5b2afc72d99f','7244b2af-a4aa-46eb-98cb-a8ece5412df2','862571e0-3fe0-44ab-8be2-b26460dcc8f9')
and eventcode='CPLAN2' and  routingstatustypeid=15 and activeflag=1 and tosecurityusersid = 'f3ba0abc-1278-4f79-ae3c-dfb167940c87' ;
