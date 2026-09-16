update adoptioncaseagreementrevision set activeflag=1,updatedon=now(),updatedby = 'CDM-1379' where adoptioncaseagreementrevisionid='1575d2ca-47b3-423c-acbe-1b366db2c7cf';

update routing set activeflag=0,updatedon=now(),updatedby = 'CDM-1379' where routingid in ('f0e4aeea-97c9-4ba6-bedd-deb850fe5c47','ae38b211-1c04-4d7b-959b-addb10e968b3', 
'215c39c3-bb81-4b1d-8d02-71fc91531b56','a7758b24-2a07-46af-940f-4449781dd671','84767d38-30b5-4038-a258-ce5876a02d51',
'36c838ef-81d1-4dfd-9fde-ae59040f82b0','4405203c-71bc-4b29-ae5f-92515340bae5','98367e8b-6d56-4eb9-a6b1-5ac8cb564636','45396e16-4200-4839-b136-ca7922f8eae5',
'5511d443-22ee-4817-9d26-82bafa916c9a','5a9097f3-5ef5-4313-a4ad-f75d2f626013','c36b41b1-1278-4b76-9235-a27e5e8c351e'
);