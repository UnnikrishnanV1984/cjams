/*
  Issue Description:CDM-40616
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
    updatedby = 'CDM-40616',
    updatedon = now()
where
    placementid ='adfe0d48-7138-478b-8c0a-dae9d36bfdbf'
    and activeflag = 1;
   
   
 update  
      livingarrangement l 
   set activeflag =0,
    updatedby = 'CDM-40616',
    updatedon = now()
where
     placementid ='adfe0d48-7138-478b-8c0a-dae9d36bfdbf'
    and activeflag = 1;
   
   
  update 
    routing
set
    activeflag=0,
    updatedby = 'CDM-40616',
    updatedon = now()    
where 
      objectid  ='adfe0d48-7138-478b-8c0a-dae9d36bfdbf'
    and activeflag = 1;

   update
    placementrevision
set
    activeflag = 0,
    updatedby = 'CDM-40616',
    updatedon = now()
where
       placementid ='adfe0d48-7138-478b-8c0a-dae9d36bfdbf'
    and activeflag = 1;
