/*
--CDM-22579-mfira

-- Issue Description: 
 User wants to change the updated by to a different name
-- Root cause: 
 UPdated to required name
-- Pull request# 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update assessment
set insertedby = '86c7c540-127d-40cf-a4d2-85dce0210d23',
updatedon = now(),
updatedby = 'CDM-22579' 
where assessmentid = 'd4aecb48-1fcb-42cf-af8a-c2e0ed558a93';
