/*
   Issue Description: CDM-33163
   Category/ Module  :Contact Note
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

UPDATE cjams.progressnote
SET updatedby='CDM-33163', updatedon=now(), progressnotereasontypekey='WV' 
WHERE progressnoteid='15d38ba1-a2fe-4549-ad69-ccabbea0b2ec';
