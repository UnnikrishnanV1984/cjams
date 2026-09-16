/*
Issue Description: User wanted to screen out the intake and remove the case connection then close the service case and intake.
Category/Module: user error
Root cause: User do not have  access update date in program assigment .
Invistgiagtion: While creating program assignment, CPS case still active.
Fix provided: DB queries to screen the intake out, close it, and remove the service case.
Data/Code fix ticket#: CJAMS-57885
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: user Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/
--update personprogramarea
update personprogramarea
set enddate = '2024-09-14 00:00:00', updatedon = now(), updatedby = 'CJAMS-57885'
where personprogramid in ('6e0c77a4-e43d-4237-a24a-a9beeba2c8e0','95ccda51-196a-4d69-b731-71f853914c0c','b009b04a-04f3-4e6f-907f-2e87ee69b29f') and activeflag =1;



