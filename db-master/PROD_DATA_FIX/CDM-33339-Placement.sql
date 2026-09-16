
/*
   Issue Description: CDM-33339
   Category/ Module  : Placement
   Root cause:  User request 
   Fix Provide: Did data fix to remove that placement record 
*/


update cjams.placement set activeflag  =0, updatedby  ='CDM-33339', updatedon  = now()
where placementid  ='59daa2a3-7f56-4034-bafa-2830309df089';

--All has no data
-- select * from cjams.tb_placement_validation where placement_id  ='1577826';
-- select * from placementrevision p  where placementid  ='59daa2a3-7f56-4034-bafa-2830309df089';
-- select * from livingarrangement l  where placementid ='59daa2a3-7f56-4034-bafa-2830309df089';
