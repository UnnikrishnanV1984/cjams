/*
  Issue Description:  CDM-39788
   Category/ Module  :  placement
   Root cause: user requested to remove blank living arrangements
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

update
    placement
set
    activeflag = 0,
    updatedby = 'CDM-39788',
    updatedon = now()
where
    placementid in ('d40b2d0a-cdc7-43a6-9460-6737f5f6427c','f57f7677-45aa-4127-82c7-8907f8e304f5')
    and activeflag = 1;
   
 ------ No record in Living arrangement-----  
update 
    routing
set
    activeflag=0,
    updatedby = 'CDM-39788',
    updatedon = now()    
where 
     objectid in ('d40b2d0a-cdc7-43a6-9460-6737f5f6427c','f57f7677-45aa-4127-82c7-8907f8e304f5')    and eventcode = 'PLTR' and activeflag = 1;

update
    placementrevision
set
    activeflag = 0,
    updatedby = 'CDM-39788',
    updatedon = now()
where
    placementid in ('d40b2d0a-cdc7-43a6-9460-6737f5f6427c','f57f7677-45aa-4127-82c7-8907f8e304f5')
    and activeflag = 1;
