/*
  Issue Description:  CJAMS-68374
   Category/ Module  :  Application
   Root cause:placement record is in rejected status and the user wants the record to be deleted
   Fix provided: Data fix is done to remove the rejected placement record
   Is code fox required: N 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

update
    placement
set
    activeflag = 0,
    updatedby = 'CJAMS-68374',
    updatedon = now()
where
    placementid ='6fc37e3a-2740-413d-b00a-9e6819dad71b'
    and activeflag = 1;
   

 update  
      livingarrangement l 
   set activeflag =0,
    updatedby = 'CJAMS-68374',
    updatedon = now()
where
     placementid ='6fc37e3a-2740-413d-b00a-9e6819dad71b'
    and activeflag = 1;
   
   
  update 
    routing
set
    activeflag=0,
    updatedby = 'CJAMS-68374',
    updatedon = now()    
where 
      objectid  ='6fc37e3a-2740-413d-b00a-9e6819dad71b'
    and activeflag = 1;

   update
    placementrevision
set
    activeflag = 0,
    updatedby = 'CJAMS-68374',
    updatedon = now()
where
       placementid ='6fc37e3a-2740-413d-b00a-9e6819dad71b'
    and activeflag = 1;