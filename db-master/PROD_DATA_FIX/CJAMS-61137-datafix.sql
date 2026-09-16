/*
CJAMS-61137
Response Timer Submission
--	Issue Description: 
 Overdue reason for Alleged victim:
-Alleged victim unavailable
-Insufficient information was reported - attempts were made
-1-2 attempts 
please update: Alleged victim unavailable > Insufficient information reported > 1-2 attempts 
-- Fix Provided: Datafix has been provided by updating with the requested values
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update cpsresponsetimeractions 
set cpsresponsetimerreason1 = 'VAVU',
cpsresponsetimerreason2 = 'VIIR',
cpsresponsetimerreason3 = 'V12R',
updatedby = 'CJAMS-61137',
updatedon = now()
where cpsresponsetimeractionsid  = '13c82d10-424b-4faa-968b-0b6916b54121';