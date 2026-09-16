/*
   Issue Description: CDM-30062
   Category/ Module  : User role issue
   Root cause: User role is mapped incorrect
   Pull request# for code fix: 8615
   Reason why no related code fix: 
    requested a data fix to resolve
*/
update teammember set roletypekey='CWSP', updatedby = 'CDM-30062', updatedon = now()  
where teammemberid = '5b43ca42-5aa1-483b-8f3d-f102a43c4488';
