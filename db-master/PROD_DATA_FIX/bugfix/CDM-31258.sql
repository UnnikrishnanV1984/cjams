 /*
Issue Description: CDM-31258
Root Cause :user is not able to see supervisor list
Data fix :Updated role type
Category/ Module: service
Pull request# N/A
Reason why no related code fix: N/A
Status of the code fix if already submitted and expected prod fix date: N/A
updating comments
*/
update teammember set roletypekey = 'CWSP',updatedon=now(),updatedby='CDM-31258' where teammemberid = '98aa9585-0e3d-4586-8424-9e044a279072';