/*
-- CDM-22384- 

-- Issue Description: 
 Unable to remove review records
  
-- Customer Email ID: wanda.nolt@maryland.gov

-- Root cause: Data fix to remove the review records
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update routing set activeflag =0, updatedon = now(), updatedby = 'CDM-22384'
where routingid in ('0e15211e-1604-4ff1-8e20-56e0c4d28e65',
'51af2854-980a-4bf2-b089-8714195dbb30',
'b387b54e-ffc0-454a-a809-5433d6dcdcda',
'a7124bfc-42eb-48c5-b8d8-0068a3576119',
'82fcd13e-57dd-4cb3-8975-641eae1ca537',
'48f1e9b9-f7c3-43f4-9838-7a076ef0800f') and activeflag =1;