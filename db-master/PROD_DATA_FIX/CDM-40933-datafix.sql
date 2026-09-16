/*
  Issue Description:  CDM-40933
   Category/ Module  :  Application
   Root cause:placement record is in rejected status and the user wants the record to be deleted
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/


update
    placement
set
    activeflag = 0,
    updatedby = 'CDM-40933',
    updatedon = now()
where
    placementid ='ceb9e324-706e-45bb-a14b-6b248fe2bfac'
    and activeflag = 1;
   
   
 update  
      livingarrangement l 
   set activeflag =0,
    updatedby = 'CDM-40933',
    updatedon = now()
where
     placementid ='ceb9e324-706e-45bb-a14b-6b248fe2bfac'
    and activeflag = 1;
   
   
  update 
    routing
set
    activeflag=0,
    updatedby = 'CDM-40933',
    updatedon = now()    
where 
      objectid  ='ceb9e324-706e-45bb-a14b-6b248fe2bfac'
    and activeflag = 1;

   update
    placementrevision
set
    activeflag = 0,
    updatedby = 'CDM-40933',
    updatedon = now()
where
       placementid ='ceb9e324-706e-45bb-a14b-6b248fe2bfac'
    and activeflag = 1;