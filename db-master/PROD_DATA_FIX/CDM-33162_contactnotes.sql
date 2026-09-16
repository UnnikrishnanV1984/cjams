/*
   Issue Description: CDM-33162
   Category/ Module  :Contact Note
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

UPDATE cjams.progressnote
SET updatedby='CDM-33162', updatedon=now(), progressnotereasontypekey='CM,MV' 
WHERE progressnoteid='abe50a70-4508-4d0a-876f-36c383270d9b';