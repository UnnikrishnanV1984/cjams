update cjams.routing 
set activeflag = 0 ,
updatedon = now(), 
updatedby = 'CDM-1320'
where routingid in ('9f0ce559-da6a-4f71-bc1a-b63c0c9355f0',
'deb26334-bdcc-4ba5-badc-657ef9e5f564',
'093668a3-158c-41c5-bb68-013afe48434f',
'1ee4aec5-09d4-4666-87a3-1317530f2b86',
'130d3e1f-d9ce-47b3-a1ab-f0e4c454f20a',
'8fb792f7-dc79-407e-9383-c90c10217d6a',
'092c1d2c-9d57-48a3-9932-e99994223a42',
'7bcf85cb-961f-48e6-ad9f-c7c818636fb5',
'fc8c4a63-08ef-42e8-ace3-c19d7495397e'
);