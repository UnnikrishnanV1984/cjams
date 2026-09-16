/*
   Issue Description: CDM-27306
   Category/ Module  : Permanency plan
   Root cause: user wants to add the updated by in GAP planning approval
   Pull request# for code fix: 7202
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/
update routing 
set fromsecurityusersid = '5ad6741c-2fc0-4f0a-879a-0a2e9dfd173b', 
    tosecurityusersid = '9a1c8c5c-cc81-4c3f-8c25-65089b46afca',
    teamid = '3800ed0f-5b2e-438c-8e80-9cb06b5d494f',
    updatedby = 'CDM-27306',
    updatedon = now()
where routingid = 'f0db11db-8046-4891-8bd8-9c0c768c90a2';