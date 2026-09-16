/*
  Issue Description:  CDM-40561
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
    updatedby = 'CDM-40561',
    updatedon = now()
where
    placementid ='5cc400d1-ce2a-43df-bae0-cccb120bf616'
    and activeflag = 1;
   
   
 update  
      livingarrangement l 
   set activeflag =0,
    updatedby = 'CDM-40561',
    updatedon = now()
where
    placementid ='5cc400d1-ce2a-43df-bae0-cccb120bf616'
    and activeflag = 1;
   
   
  update 
    routing
set
    activeflag=0,
    updatedby = 'CDM-40561',
    updatedon = now()    
where 
     objectid  ='5cc400d1-ce2a-43df-bae0-cccb120bf616' and activeflag = 1;

update
    placementrevision
set
    activeflag = 0,
    updatedby = 'CDM-40561',
    updatedon = now()
where
    placementid ='5cc400d1-ce2a-43df-bae0-cccb120bf616' and activeflag =1;
    