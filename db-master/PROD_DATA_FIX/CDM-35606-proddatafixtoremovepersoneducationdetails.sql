/*
   Issue Description: CDM-35606
   Category/ Module  : Prod data fix to update  person education details
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update personeducation set classtypetypekey = 'HS', updatedby = 'CDM-35606', updatedon = now()
 where personeducationid = 'cabe6970-b841-490d-b3f5-d28a5f42c799';