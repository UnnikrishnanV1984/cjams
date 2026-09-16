/*
Issue: Service log could not be closed because an old purchase authorization (ID 652624) was stuck in “Forwarded to Payment Approval” status.
Root Cause:Authorization was approved in 2018, but its payment status wasn’t updated in the database, causing the system to treat it as pending.
Fix Provided (Data Fix Only):Data fix was done by Updated  routing table.
Data/Code fix ticket#:CJAMS-62534
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data Error.
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/
update routing
set remarks ='Approved',updatedby='CJAMS-62534',updatedon=now()
where routingid ='a4858d97-892f-4d0a-ad18-f0b4987e67e2' and activeflag =1;