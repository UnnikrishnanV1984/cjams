/*
Issue Description: CDM-43320, Remove from supervisor dashboard.
Category/ Module: Removal
Root cause:  The respective Intake(CW2684850) is not available under the intake worker (Terri Ringler) and need to be removed.
Fix provided: Yes, write DB query.
Code fix ticket#: CDM-43320
Reason why no related code fix: Status of the code fix already submitted 
Status of the code fix if already submitted and expected prod fix date: 
void the rejected provider placement from backend
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update routing 
set activeflag=0, updatedby='CDM-43320', updatedon=NOW()
where objectid='481cc4e6-8957-4381-b86e-419cd3029aae' and routingstatustypeid = 15 and activeflag=1;