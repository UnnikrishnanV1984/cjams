/*
   Issue Description: CDM-26746
   Category/ Module  : Prod data fix to update adoption break the link
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
update adoptionchecklist set activeflag = 1, updatedon = now(), updatedby = 'CDM-26764'
where adoptionplanningid = '7f02ea60-2b85-40df-8ab4-22063749af29';		
