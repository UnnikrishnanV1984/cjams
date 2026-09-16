/*
   Issue Description: CDM-24557
   Category/ Module  : Prod data fix to fix the routing record
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

-- 3dc5f025-9f68-4812-88e2-c7ef4fbde6c6	527e483b-5108-4906-b2bb-6fdbc317f03e
update routing set fromsecurityusersid = '5ad6741c-2fc0-4f0a-879a-0a2e9dfd173b', tosecurityusersid= '9a1c8c5c-cc81-4c3f-8c25-65089b46afca',teamid= '3800ed0f-5b2e-438c-8e80-9cb06b5d494f', 
updatedon = now(), updatedby= 'CDM-24557 '
where routingid = 'f92d6e23-223c-4419-9f7a-611294dd722b';
