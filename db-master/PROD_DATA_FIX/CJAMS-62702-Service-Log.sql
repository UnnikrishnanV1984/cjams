
/*
Issue:Purchase Authorization #1781540 for case #3306988 is stuck in “Forwarded to Funding Approval” status, preventing the service log and case closure.
Root Cause:The Purchase Authorization was routed to a Finance user who no longer has access or an active assignment, causing it to remain pending without action.
Fix Provided (Data Fix Only):Data fix was done by Updated routing table 
Data/Code fix ticket#: CJAMS-62702
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/
update routing
set tosecurityusersid = '3d708382-5afa-44bd-9941-1511cf0123f4', updatedby='CJAMS-62702', updatedon=now()
where routingid = '2133b50e-20e5-4e58-942b-440e5b8b5420' and activeflag = 1;
