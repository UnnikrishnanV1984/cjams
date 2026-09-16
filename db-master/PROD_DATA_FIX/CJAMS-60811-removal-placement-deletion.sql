/*
Issue Description: Please remove/delete the child removal record of Client ID: 3697590 from case 251030480474
Category/ Module : Bug
Root cause: As worker entered the removal in the incorrect case.
Fix provided: Yes, write Db query 
Reason why no related code fix: Status of the code fix  already submitted 
Status of the code fix if already submitted and expected prod fix date: 
void the rejected provider placement from backend
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/
--removing child removal
select * from CW_transactions_dataclenup('CHLDRMVL', '3271737c-0955-4b61-b217-a994baac3fc4', 'CJAMS-60811')

/*
Removes
Transaction type is delete child removal 3271737c-0955-4b61-b217-a994baac3fc4 
Active records soft deleted from personprogramarea table. 3271737c-0955-4b61-b217-a994baac3fc4 
Active records soft deleted from intakeservreqchildremoval table. 3271737c-0955-4b61-b217-a994baac3fc4 
Active records soft deleted from intakeservreqchildremoval_history table. 3271737c-0955-4b61-b217-a994baac3fc4 
Active records soft deleted from routing table. 3271737c-0955-4b61-b217-a994baac3fc4 
Active records soft deleted from tb_client_eligibility table. 356343 
*/
