/*
Issue Description: Worker cannot add a service plan due to the previous CPS case. The case has not been end-dated. 
When I attempted to end date the case this box with red words appears
Category/Module: Error
Root cause: Old program assignments seem to not end when case is completed
Fix provided: DB query to end program assignments for all clients
Data/Code fix ticket#: CDM-41495
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data issue
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

/*
select updatedby,* from personprogramarea where personid in ('8b503643-c1b2-467c-83aa-f796f8c89fb3', 'd4af5a6d-abaf-4f0f-86d9-5652677d4e3b')
and activeflag=1 and objectid = 'a7e8a191-e88d-49e6-addd-4402ae6e1248';
*/

update personprogramarea
set enddate = '2022-08-02 00:00:00', 
	updatedby = 'b4d781df-520b-41f5-b294-654f8d9bf141',--056865a7-2a58-494e-9993-ccc6fd9aae58 got deactivated
	updatedon = now()
where 
	activeflag = 1 and 
	personprogramid in ('0b326ea3-952a-4f27-a789-b73134c5fa7a','d3f39b4e-7b84-4194-83f1-aa290be89eca');