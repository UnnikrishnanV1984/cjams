/*
   Issue Description: CDM-27191
   Category/ Module  : Placement
   Root cause: user requested  to 
     delete the living arrangement which is created in error
   Pull request# for data fix: 7236
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
update
    placement
set
    activeflag = 0,
    updatedby = 'CDM-27191',
    updatedon = now()
where
    placementid = 'eecf2f32-b0c2-49dd-83a6-241a52f01798';

 update livingarrangement
   set activeflag = 0,
    updatedby = 'CDM-27191',
    updatedon = now()
where
    placementid = 'eecf2f32-b0c2-49dd-83a6-241a52f01798';
