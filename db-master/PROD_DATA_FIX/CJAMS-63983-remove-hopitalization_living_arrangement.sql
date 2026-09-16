/*
-- CJAMS-63983 - 

-- Issue Description: 
 Delete Living Arrangement

-- Root cause: Data fix to set the active flag to zero
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update placement 
set activeflag =0, updatedby ='CJAMS-63983',updatedon = now()
where placementid ='58b6766a-baf1-42d4-b8fe-b53550629659' and activeflag = 1;

update placementrevision 
set activeflag =0, updatedby ='CJAMS-63983',updatedon = now()
where placementid ='58b6766a-baf1-42d4-b8fe-b53550629659' and activeflag = 1;

update livingarrangement 
set activeflag =0, updatedby ='CJAMS-63983',updatedon = now()
where placementid ='58b6766a-baf1-42d4-b8fe-b53550629659' and activeflag = 1;

update routing  
set activeflag =0, updatedby ='CJAMS-63983',updatedon = now()
where objectid ='58b6766a-baf1-42d4-b8fe-b53550629659' and activeflag = 1;


update personhospitalization set objectid = null, updatedby ='CJAMS-63983',updatedon = now(), activeflag = 1
where hospitalizationid = 'e9318e1f-53b2-48bc-84d8-730228371cba' and objectid = '5a284d5e-ab9f-4f0c-a4ab-f37f4a2cc515';
