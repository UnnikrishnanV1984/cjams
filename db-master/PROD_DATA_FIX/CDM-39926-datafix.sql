/*
  Issue Description:  CDM-39926
   Category/ Module  :  placement
   Root cause: user requested to remove the duplicate Living Arrangement
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

update
    placement
set
    activeflag = 0,
    updatedby = 'CDM-39926',
    updatedon = now()
where
    placementid ='3184dbee-a50c-4613-81bf-8edb0d8ba7fa'
    and activeflag = 1;
   
update
   livingarrangement 
set
    activeflag = 0,
    updatedby = 'CDM-39926',
    updatedon = now()
where
    placementid ='3184dbee-a50c-4613-81bf-8edb0d8ba7fa'
    and activeflag = 1; 

   update 
    routing
set
    activeflag=0,
    updatedby = 'CDM-39926',
    updatedon = now()    
where 
     objectid ='3184dbee-a50c-4613-81bf-8edb0d8ba7fa'    and eventcode = 'PLTR' and activeflag = 1;

update
    placementrevision
set
    activeflag = 0,
    updatedby = 'CDM-39926',
    updatedon = now()
where
    placementid ='3184dbee-a50c-4613-81bf-8edb0d8ba7fa'
    and activeflag = 1;