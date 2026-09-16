/*
   Issue Description: CDM-7959 -- Child Account Disbursement
   Category/ Module  :  Child account
   Root cause: Unable to reproduce this. Will ask QA team to reproduce this.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
update usernotification set 
subject='Final Disbursement transaction Payment Approval Request for Client Name - "TYLER SATER" (Client Account "F980535")  has been approved by  "Tracy Gray"',
"body"='Final Disbursement transaction Payment Approval Request for Client Name - "TYLER SATER" (Client Account "F980535")  has been approved by  "Tracy Gray"',
insertedby='a7b7b759-341a-4604-a853-3a922c75fb4d',
updatedby='CDM-7959',
updatedon=now()
where usernotificationid in ('9b5bd56a-66bb-41e6-92c1-ab15199a71c9','a86c0014-e385-4077-a38d-3adabbc629d0');

update usernotificationmap set insertedby='a7b7b759-341a-4604-a853-3a922c75fb4d',
fromsecurityusersid='a7b7b759-341a-4604-a853-3a922c75fb4d',updatedby='CDM-7959',updatedon=now() where usernotificationid in ('9b5bd56a-66bb-41e6-92c1-ab15199a71c9','a86c0014-e385-4077-a38d-3adabbc629d0');
