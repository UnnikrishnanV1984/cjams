/*
Issue:3275838:I have a duplicate service agreement. The one that is dated July 18, 2025 has the incorrect date on it. Can you please delete this service agreement
Root cause: User request to delete duplicate record in service agreemeny due to they do not have access to delete record in application.
Fix provided: DB queries  update enddate serviceagreement table.
Data/Code fix ticket#: CJAMS-61066
Regression Impacts: N/A 
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: The fix required is a data correction and proper user workflow .
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update serviceagreement
set activeflag = 0 ,updatedby = 'CJAMS-61066', updatedon  = now(),caseid = null
where agreementid  = '94b25298-af6d-48b7-a320-97e1fffb861a' and activeflag =1;


update routing
set activeflag = 0 ,updatedby = 'CJAMS-61066', updatedon  = now()
where routingid = '2d7b3e59-fd73-420e-9778-fa70ebb07cc6' and activeflag =1;
