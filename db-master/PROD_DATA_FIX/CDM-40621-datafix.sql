/*
  Issue Description:CDM-40621
Category/ Module:Application
Root cause: User  requested to remove the living arrangements
Pull request# for code fix:
Reason why no related code fix:
Status of the code fix if already submitted and expected prod fix date:
   Backup before update/ delete: 
*/

update
    placement
set
    activeflag = 0,
    updatedby = 'CDM-40621',
    updatedon = now()
where
    placementid ='eedda2e9-8515-4580-88f7-245d847c9a20'
    and activeflag = 1;
   
   
 update  
      livingarrangement l 
   set activeflag =0,
    updatedby = 'CDM-40621',
    updatedon = now()
where
     placementid ='eedda2e9-8515-4580-88f7-245d847c9a20'
    and activeflag = 1;
   
   
  update 
    routing
set
    activeflag=0,
    updatedby = 'CDM-40621',
    updatedon = now()    
where 
      objectid  ='eedda2e9-8515-4580-88f7-245d847c9a20'
    and activeflag = 1;

   update
    placementrevision
set
    activeflag = 0,
    updatedby = 'CDM-40621',
    updatedon = now()
where
       placementid ='eedda2e9-8515-4580-88f7-245d847c9a20'
    and activeflag = 1;