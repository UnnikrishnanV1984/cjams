/*
   Issue Description: CJAMS-58395
   Category/ Module  : case still appearing on the to be assigned dashboard
   Root cause: Data fix is requested to remove the case from the to be assigned dashboard
   Pull request# for code fix: na
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update servicecase set statustypekey  = 'ASSGN', updatedon = now(), updatedby = 'CJAMS-58395' 
where servicecaseid = '668364b0-366f-40a6-89df-331d809b38fd' and servicecasenumber ='2020034204610';
