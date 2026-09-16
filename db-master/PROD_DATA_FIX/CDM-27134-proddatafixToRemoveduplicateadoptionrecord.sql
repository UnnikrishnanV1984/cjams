/*
   Issue Description: CDM-27134
   Category/ Module  : Prod data fix to remove duplicate adoption records
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

  update adoptionapplicabilityinfo set activeflag =0 , updatedby = 'CDM-27134', updatedon = now()
  where adoptionapplicabilityid = '2741207e-9f1e-4e79-aa8c-56f46daddbcf';