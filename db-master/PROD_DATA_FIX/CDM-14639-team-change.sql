/*   Issue Description: CDM-14639--worker not showing after update in sailpoint 
   Category/ Module  :  Staff management
   Root cause: sailpoint issue. Sailpoint team is trying to reproduce it.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
-- Backupd: old value : teamid = 5be9200d-9396-45c6-bfa4-c13a8bf19fcc
*/

update teammember set teamid='86b1426d-675d-4a17-b94b-2f5120122541', updatedby='CDM-14639',updatedon=now() where 
teammemberid='0d403ddd-e4fb-4a62-a9d3-2dd516b60bb4';
