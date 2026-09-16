/*
   Issue Description: CDM-21861
   Category/ Module  : Placement
   Root cause: user wants to add living arrangement update
   Pull request# for code fix: 5669
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
 Need to do data fix
*/
update livingarrangement 
set livingarrangementtypekey = 'PSYH', streetname = '6501 N Charles St', cityname = 'Towson', 
    countytypekey = 'Baltimore', statetypekey = 'MD', zip5no = '21204', updatedon = now(), updatedby = 'CDM-21861' 
where livingid = 'caac9383-36e0-452a-8be3-d6db7dfcebf3';
