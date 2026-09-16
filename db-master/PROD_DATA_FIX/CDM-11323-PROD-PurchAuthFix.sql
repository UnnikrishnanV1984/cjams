update routing 
set activeflag =0, updatedon =now(), updatedby ='CDM-11323'
where routingid in ('fc85fcf7-524f-4de5-bec4-ef90aa9ba76a',
'1dfcc740-a003-4a25-b481-2e8c512c35f7');

update routing 
set activeflag =1, updatedon =now(), updatedby ='CDM-11323'
where routingid ='4faec434-2305-419a-9294-e10e0417fea5';

delete from routing 
where routingid in ('0cd7a11e-bbba-4ab5-92e9-cd06740b07ae',
'66c8e411-2322-4478-b956-4d9ad6e3e137',
'37b984cd-a4f7-4bdc-a958-057679e2926d',
'bb206009-3ea4-49d0-aad1-63a1635a9a91',
'5b8eb08e-4c7f-44c5-b239-ae11175a0d77');