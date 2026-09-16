/*
   Issue Description: CIDM-10724
   Category/ Module  : Prod data fix to update inactive legislative records so primary key can be added.
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Need to do data fix
*/

UPDATE legislative
SET legislativeid = gen_random_uuid(),
    updatedon = NOW(),
    updatedby = 'CIDM-10724'
WHERE legislativeid IN (
    'b08048f1-3cd1-4e27-9127-848585afc49d',
    '72b7eaf3-c8bd-4919-b932-774132591c7d'
)
AND activeflag = 0;