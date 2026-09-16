/*
   Issue Description: CIDM-7018
   Category/ Module  : Updating the county 
   Root cause: Soft deleting the removal record 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update referencevalues set activeflag='0', updatedon = now() where ref_key in ('42c183e0-1af2-4369-8e07-bdea100eed54',
'58f21314-5daf-417f-9216-5a9b2da013d8','51f1c280-1c0a-4921-923c-f66c556ef4fe');
 