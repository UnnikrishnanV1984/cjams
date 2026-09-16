/*
Issue Description: 
Category/ Module : Bug
Root cause: One Provided Placement entry had a duplicate under the name Living Arrangement.
Fix provided: Yes, write Db query 
Code fix ticket#: CDM-43071
Reason why no related code fix: Status of the code fix  already submitted 
Status of the code fix if already submitted and expected prod fix date: 
void the rejected provider placement from backend
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update placement
set activeflag=0, updatedby='CDM-43071', updatedon=now()
where placementid='3f913333-246e-4620-b802-03e422416b58' and activeflag=1;

update placementrevision
set activeflag=0, updatedby='CDM-43071', updatedon=now()
where placementrevisionid='4a13e02b-4764-4275-9187-77e017cdf2f3' and activeflag=1;

update routing
set activeflag=0, updatedby='CDM-43071', updatedon=now()
where objectid='3f913333-246e-4620-b802-03e422416b58' and activeflag=1;

update livingarrangement
set activeflag=0, updatedby='CDM-43071', updatedon=now()
where livingid='981d8710-5640-4165-85e8-f6b03e2e8e26' and activeflag=1;
