--- Party Row ID - 10740926      

update personidentifier 
set
personidentifiervalue = 'MDT-129064982',
updatedby = 'MDM Merge issue',
updatedon = now() 
where 
personidentifierid = '1b36f2c3-c448-4508-b0ef-b1bc64a52b1d';

update personidentifier 
set
activeflag = 0,
updatedby = 'MDM Merge issue',
updatedon = now() 
where 
personidentifierid = '59cbea5a-18b2-4f32-a7c1-6011e8bbe537';

--- Party Row ID - 10030891      CDM-13026

update personidentifier 
set
personidentifiervalue = 'MDT-137971565',
updatedby = 'CDM-13026',
updatedon = now() 
where 
personidentifierid = 'ace316dd-1a95-4d53-800d-500248648b04';

update personidentifier 
set
personidentifiervalue = 'MDT-137258785',
updatedby = 'CDM-13026',
updatedon = now() 
where 
personidentifierid = 'a4f95983-aa80-458c-9c56-9eda0e93fc43';


-- Party Row ID 10743829      CDM-12417

update personidentifier 
set
personidentifiervalue = 'MDT-124314483',
updatedby = 'CDM-12426',
updatedon = now() 
where 
personidentifierid = 'fef6c0ad-ade1-46f2-95d0-7a03596a6ae9';

update personidentifier 
set
personidentifiervalue = 'MDT-138108400',
updatedby = 'CDM-12426',
updatedon = now() 
where 
personidentifierid = '2225fd58-88b2-46cf-9163-65b9628ad3dd';


update person
set
activeflag = 1,
updatedby = 'CDM-12426',
updatedon = now() 
where
personid = 'cc418323-5907-4273-ae24-fcb293f6b437';