/*
   Issue Description: CDM-30854
   Category/ Module  : Address
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update cjams.referencevalues
set ref_key = '1b7ae41e-e77a-4a1e-a0a3-cda5292cde0b',
    activeflag = 1,
    updatedby = 'CDM-30854',
   updatedon = now()
WHERE ref_key = '7665ca54-5374-4174-be07-a687b811a82c'
and activeflag = 0 ;
