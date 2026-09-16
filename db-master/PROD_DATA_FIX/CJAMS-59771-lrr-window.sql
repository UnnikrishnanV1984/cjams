-- CJAMS-59771 - LRR Reporting Window
/* Issue Description: 251023012300:Please revise LRR window reason for AV:"Data entry error but met mandate"
-- Category/ Module: LRR window 
-- Root cause: User Error, Wrong reason was added. 
-- Fix Provided: Datafix has been provided to updating with the requested reason
-- Pull request# N/A
*/

update cpsresponsetimeractions 
set cpsresponsetimerreason1 = 'VDER',
updatedby = 'CJAMS-59771',
updatedon = now()
where cpsresponsetimeractionsid  = 'f1369e84-04cf-4458-9f84-82195f2c02c3';