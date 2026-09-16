/*
  Issue Description:  CDM-40552
   Category/ Module  :  Application
   Root cause: User  requested to remove the living arrangement
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

update
    placement
set
    activeflag = 0,
    updatedby = 'CDM-40552',
    updatedon = now()
where
    placementid ='cb068a9f-1a29-42e4-afd7-3096f4d51cbe'
    and activeflag = 1;
   
   
 update  
      livingarrangement l 
   set activeflag =0,
    updatedby = 'CDM-40552',
    updatedon = now()
where
    placementid ='cb068a9f-1a29-42e4-afd7-3096f4d51cbe'
    and activeflag = 1;
   
   
  update 
    routing
set
    activeflag=0,
    updatedby = 'CDM-40552',
    updatedon = now()    
where 
     objectid  ='cb068a9f-1a29-42e4-afd7-3096f4d51cbe' and activeflag = 1;

update
    placementrevision
set
    activeflag = 0,
    updatedby = 'CDM-40552',
    updatedon = now()
where
    placementid ='cb068a9f-1a29-42e4-afd7-3096f4d51cbe' and activeflag =1;
