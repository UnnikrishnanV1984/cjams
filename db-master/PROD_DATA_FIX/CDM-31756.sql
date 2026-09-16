/*
   Issue Description: CDM-31756
   Category/ Module  : YTP
   Root cause: user wants to  remove the YTP pending approval from the user dashboard
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/
update routing set activeflag =0, updatedby = 'CDM-31756', updatedon =now() where routingid = '7fa52662-5ffd-4f95-8e28-393c85dfb080';
