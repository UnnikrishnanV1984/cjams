/*
Issue: CJAMS-65046 
Category/Module: Program Assignments
Root cause: Delete Program Assignment associated with case 261023574908.
Fix provided:  Data fix is done as the part of this ticket to remove the incorrect program assignment.
Regression Impacts: N/A
Is Code fix Required?: Yes
Code fix ticket#: NA
Reason why no related code fix: N/A
*/

update personprogramarea
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-65046'
where personprogramid IN ('56584439-9a65-4b73-b5d9-380c78a0dfb5',
						'544373d5-0718-4074-892f-840ecf7d87df',
						'07fba603-c1d3-400a-ae82-23ca393c65d3')
and activeflag =1;    