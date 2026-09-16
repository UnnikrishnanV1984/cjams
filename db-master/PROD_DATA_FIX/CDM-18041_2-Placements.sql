-- CDM-18041 - System Allowing 2 Placement at same time
/*
-- Issue Description: System Allowing 2 Placement at same time
	 Add void to the placement as per ticket.
   
-- Category/ Module: Placement History
-- Root cause: Placement was duplicated .
-- Pull request# N/A
-- Reason why no related code fix:  code fixed in another ticket.
-- Status of the code fix if already submitted and expected prod fix date: Good/N/A
*/


update cjams.placement 
set isvoided = 1, voiddate = now(), voidreasontypekey='WKER', 
 voidremarks = 'User Request', updatedby = 'CDM-18041', updatedon = now()  
 where placementid = '4d19725c-cd23-4295-9026-45feca5dc522';

update cjams.placementrevision 
set isvoided = 1, voiddate = now(), voidreasontypekey='WKER', 
 voidremarks = 'User Request', updatedby = 'CDM-18041', updatedon = now()  
 where placementid = '4d19725c-cd23-4295-9026-45feca5dc522';

update tb_placement_validation set delete_sw='Y', 
update_user_id = 'CDM-18041', update_ts = now()
where placement_id=1567229 and placement_validation_id=1984046;