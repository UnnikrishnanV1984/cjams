/*
Issue Description: Please remove the Case Plan pending approval for case # 3281329 & # 3181462 from the supervisor approval dashboard.
Category/Module: Error
Root cause: Old service case plan requests still lingered in approval inbox
Fix provided: DB query to deactivate the csae plan approval requests
Data/Code fix ticket#: CDM-42252
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating routing
update routing
set activeflag = 0, updatedby = 'CDM-42252', updatedon = now()
where routingid in ('ede24eb7-e804-4229-81d2-e1aa362bc9d8', 'd66082e3-1d40-478d-a5f4-46e197e1ca7f') and activeflag = 1;