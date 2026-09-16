
/*
Issue Description: CJAMS-67614
Category/Module: Approval Inbox
Root cause: I have several line items in my approvals that will not be cleared 
Fix provided: Data fix has been promoted to remove the Cases from approval inbox.  
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix: Data fix 
*/

update routing set activeflag =0, updatedby = 'CJAMS-67614',
updatedon = now() where routingid  in ('89a5a813-a0cb-4fe9-a3e8-bab3b8f429ba','3db6b521-f93b-4bea-9270-794d8d83d6b6','2e444c6e-8c24-4d31-a564-a8b0eb03d06c','cd7a141c-62fa-4a99-b9d0-2fb65037b421')
and activeflag =1;