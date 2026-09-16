/*
Issue Description: Please delete the blank program assignments from cases 241030273211, 241030329105
Category/ Module: Error
Root cause: User selected start date but it did not show after saving.
Fix provided: DB query to deactivate the blank program assignments.
Code/Data fix ticket#: CDM-40472
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: CDM-40472
Reason why no related code fix: DB issue, code is fine
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Deactivating for case 241030273211 from personprogramarea
update personprogramarea
set activeflag = 0, updatedon = now() ,updatedby = 'CDM-40472'
where personprogramid in ('7c18be8d-ce19-49e5-8e33-b79d7abb49e5', '0ae98550-c6d7-4d7d-b922-b83c0bc4c81d') and activeflag = 1;

--Deactivating for case 241030329105 from personprogramarea
update personprogramarea
set activeflag = 0, updatedon = now(), updatedby = 'CDM-40472'
where personprogramid in ('126ed895-466f-4120-88ce-6e8e82c312dc', '25805169-04cf-49e4-9e37-6e69ec6215a2') and activeflag = 1;