-- CDM-33452 - Delete APprovals from inbox
/*
   Issue Description: CDM-33452
      Category/ Module  :  
   Root cause:  User request to delte approval from inbox
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 

(select r.routingid from  servicecase S
INNER JOIN
(
SELECT    DISTINCT  R.routingid, r.servicerequestnumber
FROM ROUTING R
WHERE R.tosecurityusersid = 'f3ba0abc-1278-4f79-ae3c-dfb167940c87'
AND routingstatustypeid in(15,39)
AND R.activeflag =1
AND R.eventcode NOT IN ('ASST')
)R ON r.servicerequestnumber = S.servicecasenumber::character varying) ;
*/

update routing set activeflag=0, updatedby ='CDM-33452', updatedon = now()  where routingid in ('ac0aad70-ae94-45dd-835d-15c136a3710c',
'1171eaa8-013b-4057-883e-556a02e5e4cd',
'1cd2f9e4-a7cd-4fae-abd6-a2cbd3e5479e','5c5c51f9-2bed-4d26-8a77-3b894d8b63f0',
'62b739c4-9e0f-4407-b08a-5d38c30ed009','21493bec-3042-4418-bfe6-b8e36677fad3',
'02800128-6f88-49b6-b0a0-f65cfabb249e','25cc5693-738b-4e34-80bf-ce95996709e9',
'a368b6e4-be84-4360-835d-1ec66265ee33','4ed4995f-f85c-4fb1-ad00-44453af94731',
'a8156465-638f-45bd-83c5-02968239b09b','4d338af4-2307-4735-8b53-c2b697535876',
'fa12f7e2-b254-4ef0-8395-28523cd1b230',
'7244b2af-a4aa-46eb-98cb-a8ece5412df2','ff4068ab-2615-4cb3-b93f-e536b36f4b37',
'3b280345-0c16-4f79-bcd4-108201afcb29','98fb45ef-a231-4e32-9bef-4043a27d4cc2',
'fdaae12c-8a39-4ce4-a446-e1ea7d4bfd02','19de3069-21b8-439a-bc18-918c35841697',
'be59d449-665a-45e7-ab9f-943a85310532','867baacd-f3f0-4c75-9b34-c72c863682ce',
'51273c61-f36e-4a5c-bfa9-29133fd04704','0ad034b7-2491-40ea-b808-58ce7984e659',
'5e7dc9c8-0c02-403d-9506-694c42ae37c1','f5107d35-1824-4d44-891c-588a2a9c261a',
'afef3bb3-36b4-4491-a390-5b2afc72d99f','4a85ab38-8f52-44d3-b505-078d4b7dbaa5',
'862571e0-3fe0-44ab-8be2-b26460dcc8f9','07aa84de-2ebc-4d30-97e3-4feae57f5b88',
'e16df0c2-51f7-4a96-b3c2-fdf720e5a9c4','f651c1e7-5366-4235-afdd-c8278b1d10ca',
'6bc6bdf8-9e2f-48f3-b8eb-326f0cc5bdec','3c27720b-7b77-4651-8e54-894a64305a28');

