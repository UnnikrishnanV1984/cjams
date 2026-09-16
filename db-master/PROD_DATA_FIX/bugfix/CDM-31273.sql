
/*
Issue Description: CDM-31273
Root Cause :Updated the client Id as per request
Data fix :Updated clientid 
*/
UPDATE assessment 
SET 
updatedby = 'CDM-31273', 
updatedon = now(),  submissiondata=jsonb_set(submissiondata, '{clientid}', '"4357901"')
where assessmentid='3f89e199-a193-480d-8eb7-0f8df195d14b';