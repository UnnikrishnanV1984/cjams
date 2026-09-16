/*
  Issue Description:CDM-40615
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
    updatedby = 'CDM-40615',
    updatedon = now()
where
    placementid in ('61a20710-3c99-417a-bbe3-4882f7c53299','78980ae3-69df-4693-90e2-6461223c10c7','b4a81b7c-e3b5-46ff-82ab-383a89b18f34')
    and activeflag = 1;
   
   
 update  
      livingarrangement l 
   set activeflag =0,
    updatedby = 'CDM-40615',
    updatedon = now()
where
    placementid in ('61a20710-3c99-417a-bbe3-4882f7c53299','78980ae3-69df-4693-90e2-6461223c10c7','b4a81b7c-e3b5-46ff-82ab-383a89b18f34')
    and activeflag = 1;
   
   
  update 
    routing
set
    activeflag=0,
    updatedby = 'CDM-40615',
    updatedon = now()    
where 
     objectid in ('61a20710-3c99-417a-bbe3-4882f7c53299','78980ae3-69df-4693-90e2-6461223c10c7','b4a81b7c-e3b5-46ff-82ab-383a89b18f34');

update
    placementrevision
set
    activeflag = 0,
    updatedby = 'CDM-40615',
    updatedon = now()
where
   placementid in ('61a20710-3c99-417a-bbe3-4882f7c53299','78980ae3-69df-4693-90e2-6461223c10c7','b4a81b7c-e3b5-46ff-82ab-383a89b18f34') and activeflag =1;