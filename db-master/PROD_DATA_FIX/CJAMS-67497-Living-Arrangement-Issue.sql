/*
Issue Description: Please Delete living arrangement as per DEV recommended fix and confirmed with user
Category/ Module : Bug
Root cause: Living arrangement entry had intermittent issue.
Fix provided: Yes, write Db query 
Reason why no related code fix: Status of the code fix  already submitted 
Status of the code fix if already submitted and expected prod fix date: 
void the rejected provider placement from backend
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/
--removing living arrangement
select * from CW_transactions_dataclenup('PLCMT', 'c6e85b23-19fb-4be5-841a-1c0cf07194d0', 'CJAMS-67497');
