-- CDM-19160 -placement end date
/*
 Issue Description: CDM-15715
   Category/ Module :Intake- pending approval
   Root cause: user wants to record from pending approval
   Pull request# for code fix: 
   Explanantion: user wants to delete record from pending approval
*/

-- Datafix to re-open the Placement, Removal, OOH & IV-E

update routing 
        set activeflag = 0,updatedon = now(), updatedby = 'CDM-15715'
       where objectid  = 'I202100552858'
      and routingid = 'ce8bb55a-8531-46f9-b32d-2826b7d78545';