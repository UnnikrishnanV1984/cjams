

/*
   Issue Description: CDM-25884
   Category/ Module  :  Placement
   Root cause: user requeseted to update placement Info
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/  


update cjams.placement  set exittypekey ='PLCC', exitreasontypekey ='CIPO', endtime ='12.00', updatedby ='CDM-25884', updatedon =now()

where placementid ='13885bd7-c1ed-4b05-b843-17ae79de1e41';