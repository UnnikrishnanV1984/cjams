/* 
    Issue Description: CDM-39768
  Category/ Module  : 
  Root cause: User request to delete rejected Living Arrangement
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date: 
  Backup before update/ delete: 
*/

update
    placement
set
    activeflag = 0,
    updatedby = 'CDM-39768',
    updatedon = now()
where
    placementid='92cac632-c150-42d9-a358-b0dc8fb9d6b7'
    and activeflag = 1;
   
update
   livingarrangement 
set
    activeflag = 0,
    updatedby = '39768',
    updatedon = now()
where
    placementid='92cac632-c150-42d9-a358-b0dc8fb9d6b7'
    and activeflag = 1;
   

update 
    routing
set
    activeflag=0,
    updatedby = '39768',
    updatedon = now()    
where 
     objectid ='92cac632-c150-42d9-a358-b0dc8fb9d6b7' and eventcode = 'PLTR' and activeflag = 1;

update
    placementrevision
set
    activeflag = 0,
    updatedby = '39768',
    updatedon = now()
where
    placementid ='92cac632-c150-42d9-a358-b0dc8fb9d6b7'
    and activeflag = 1;