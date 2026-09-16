/*
Issue Description:the CPS IR (# 251023050879) case connect request was submitted on 07/03/2025, 11:39 AM and the CPS IR case is closed on 07/03/2025, 11:58 AM.
Category/Module: Error
Root cause: User Request, the CPS IR (# 251023050879) case connect request was submitted on 07/03/2025, 11:39 AM and the CPS IR case is closed on 07/03/2025, 11:58 AM.
The supervisor is requested to remove the case connect review from their Supervisor approval inbox as the CPS IR has been closed.

Fix provided: DB queries to remove the routing record from the supervisor dashboard.
Data/Code fix ticket#:CJAMS-60467
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update routing 
set activeflag = 0, updatedby = 'CJAMS-60467', updatedon = now()
where routingid = 'd619123d-5864-4f6d-9ce0-ac581c4fe9ee' and activeflag = 1;