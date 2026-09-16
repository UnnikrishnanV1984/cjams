/*
   Issue Description: CDM-24461
   Category/ Module  : Prod data fix to update the user resource
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

UPDATE cjams.userresource set activeflag=1, updatedby = 'CDM-24461', updatedon = now()
WHERE userresourceid='15b6584d-5a93-44e1-b328-d03fd21a0aa3';

