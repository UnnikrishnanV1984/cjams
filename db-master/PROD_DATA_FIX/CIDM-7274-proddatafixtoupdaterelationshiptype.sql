/*
   Issue Description: CIDM-7274
   Category/ Module  : Prod data fix for updating permanency plan
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/



update relationshiptype set fourerelid = '1015', updatedby = 'CIDM-7274', updatedon = now()
where relationshiptypekey = 'NORELTVE';