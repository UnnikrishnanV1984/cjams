/*
Issue Description: CDM-40527, where User wants the historic intake to remove from dashboard. The case entirely (CW2684850).
Category/ Module: Removal
Root cause:  The respective Intake(CW2684850) is not available under the intake worker (Terri Ringler) and need to be removed.
Fix provided: Yes, write DB query.
Code fix ticket#: CDM-40527
Reason why no related code fix: Status of the code fix already submitted 
Status of the code fix if already submitted and expected prod fix date: 
void the rejected provider placement from backend
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update routing 
set 
	activeflag=1,updatedby='CDM-40527',updatedon=now() 
where 
	routingid='5881da89-dcf0-4221-926f-f4ad34584e56';

update intakedastaging  
set 
	status='Complete' 
where 
	intakenumber='CW2684850' and activeflag=1;
