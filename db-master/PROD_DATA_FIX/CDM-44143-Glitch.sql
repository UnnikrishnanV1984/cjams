/*
Issue Description: Need data fix to remove all related YTP requests for both cases from the supervisor pending approval inbox.
Category/Module: Data  glitch
Root cause: Data glitch casue request to remain after approval.
Fix provided: DB queries to YTP remove approval requests routing
Data/Code fix ticket#: CDM-44143
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data  glitch
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--update routing
update routing 
set activeflag = 0, updatedby = 'CDM-44143',updatedon = now()
where routingid  in ('64e6176c-f081-4f63-886c-aba9fcab9904','a88d30bc-0957-4611-8fa9-c0e19961d3d8','cc9834a9-04b1-44f2-9816-c046361a76ba')  and activeflag = 1 ;

 update routing 
set activeflag = 0, updatedby = 'CDM-44143',updatedon = now()
where routingid  = '8953b095-5696-4849-9986-323a7d676d61'   and activeflag = 1;