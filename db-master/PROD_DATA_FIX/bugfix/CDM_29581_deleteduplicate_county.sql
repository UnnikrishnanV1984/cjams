
/*
   Issue Description: CDM-29581
   Category/ Module  : Delete Duplicate county
   Root cause:
   Pull request# for code fix: 
   Reason why no related code fix:  
   Status of the code fix if already submitted and expected prod fix date: 
*/


UPDATE referencevalues 
set activeflag=0
where activeflag=1 
and referencetypeid = '306' 
and ref_key = '7665ca54-5374-4174-be07-a687b811a82c'
and value_text = 'Baltimore City';