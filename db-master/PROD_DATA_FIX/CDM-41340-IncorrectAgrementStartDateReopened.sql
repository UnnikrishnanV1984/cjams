/*
Issue Description: Data fix on the GAP Agreement start date is not reflected in Production.
Please do a data fix to change the agreement date to 08/09/2024
Category/Module: Error
Root cause: User changed the court order date back to 08/28/2024 on 9/13/2024
Fix provided: DB query to change court order date back to 08/09/2024
Data/Code fix ticket#: CDM-41340
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating start date in intakeservreqcourtorder
update intakeservreqcourtorder
set courtorderdate = '2024-08-09 04:00:00', updatedby = 'CDM-41340', updatedon = now()
where intakeservreqcourtorderid = '2d2edde9-535f-435a-b995-5be5f1c3a48e' and activeflag = 1;