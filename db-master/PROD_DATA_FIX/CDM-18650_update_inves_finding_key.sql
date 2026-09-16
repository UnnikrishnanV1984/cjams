/*
   Issue Description: CDM-18650
   Category/ Module  : Investigation findings  
   Root cause: User wants to update investigation finding type key
   Pull request# for code fix: 4453
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update investigationfinding set investigationfindingtypekey = 'RO', updatedby = 'CDM-18650', updatedon = now()
where investigationfindingid in ( '5f02d107-8032-4d5a-9957-5db683fe84ff', 'a11f4c7f-068a-4f55-b8ad-e1c52d689bf7');