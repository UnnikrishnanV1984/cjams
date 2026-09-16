/*   Issue Description: CDM-42755-- The appeals coordinator Amber Barnes is no longer a selection in CJAMS for Charles County
   Category/ Module  :  Staff management
   Root cause: sailpoint issue, Multi county setup cannot be done from sailpoint. Also, default St. Mary's LDSS teamid was present in backend in cjams db rather than the charles county's LDSS teamid
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
-- Backupd: old value : teamid = fa016d55-e106-49a2-8862-7a38cb865fde
*/

-- ldss management for Charles County: 848bbdd0-0aef-4790-802d-e08275666fc2

/*select teammemberid,teamid, loadnumber, roletypekey, updatedby, updatedon  
from teammember 
where teammemberid in ( 
select teammemberid 
from teammemberassignment 
where securityusersid  = '1019e183-a7ab-4244-a728-854f03a3a477'
)
and activeflag  = 1*/
-- old: fa016d55-e106-49a2-8862-7a38cb865fde
update teammember set teamid='848bbdd0-0aef-4790-802d-e08275666fc2', updatedby='CDM-42755',updatedon=now() where 
teammemberid='fa016d55-e106-49a2-8862-7a38cb865fde';