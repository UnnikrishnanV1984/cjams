/*
   Issue Description: CDM-31163
   Category/ Module  : Prod data fix to update investigation findings to unsubstantiated
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Need to do data fix
*/

update investigationallegationmaltreators set overridefindingtypekey = null,updatedby ='CDM-31163',updatedon =now() where investigationallegationmaltreatorsid = '0bc18e08-d0f6-43e1-99cc-0541dec92cba';