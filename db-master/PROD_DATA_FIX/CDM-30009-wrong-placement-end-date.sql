/*
   Issue Description: CDM-30009
   Category/ Module  :  remove the Living Arrangement end date 
   Root cause: user wants to remove
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update
    livingarrangement
set
    livingenddate = NULL,
    updatedon = now(),
    updatedby = 'CDM-30009'
where
    placementid = 'e5c49ae3-6e6b-4f5e-b10c-17c48fd19e0e';


update
    placement
set
    enddatetime = NULL,
    updatedon = now(),
    updatedby = 'CDM-30009'
where
    placementid = 'e5c49ae3-6e6b-4f5e-b10c-17c48fd19e0e';


update
    placementrevision
set
    exitdate = NULL,
    updatedby = 'CDM-30009',
    updatedon = now()
where
    placementid = 'e5c49ae3-6e6b-4f5e-b10c-17c48fd19e0e'
    and activeflag = 1;
