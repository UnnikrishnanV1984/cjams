/*
Issue Description: 
Category/ Module : Bug
Root cause: One Provided Placement entry had a duplicate under the name Living Arrangement.
Fix provided: Yes, write Db query 
Code fix ticket#: CDM-43070
Reason why no related code fix: Status of the code fix  already submitted 
Status of the code fix if already submitted and expected prod fix date: 
void the rejected provider placement from backend
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/




update placement
set activeflag=0, updatedby='CDM-43070', updatedon=now()
where placementid='37413ead-3c2e-416d-8adb-d52e9bcdb92b' and activeflag=1;


update placementrevision
set activeflag=0, updatedby='CDM-43070', updatedon=now()
where placementrevisionid='109d4d08-af30-436c-94a4-d12476ff9633' and activeflag=1;

update routing
set activeflag=0, updatedby='CDM-43070', updatedon=now()
where objectid='37413ead-3c2e-416d-8adb-d52e9bcdb92b' and activeflag=1;

update livingarrangement
set activeflag=0, updatedby='CDM-43070', updatedon=now()
where livingid='f3ac4b4c-315c-4d8c-ae3f-427fae11bd94' and activeflag=1;
