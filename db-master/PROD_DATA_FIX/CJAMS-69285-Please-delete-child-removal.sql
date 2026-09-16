/*
Issue Description: Supervisor approved and proceed with data fix to delete 7/17 child removal date for Milynn Simms (#3171790). 
Category/ Module : Bug
Root cause: As worker entered the removal in the  case.
Fix provided: Yes, write Db query 
Reason why no related code fix: Status of the code fix  already submitted 
Status of the code fix if already submitted and expected prod fix date: 
void the rejected provider placement from backend
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/
--removing child removal
select * from CW_transactions_dataclenup('CHLDRMVL', '9aa93b54-b7c0-439b-9b30-f6c910d691b7', 'CJAMS-69285');
