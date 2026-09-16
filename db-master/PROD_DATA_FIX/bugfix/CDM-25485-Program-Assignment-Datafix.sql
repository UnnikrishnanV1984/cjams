-- CDM-25485 - Program Assignment
/*
-- Issue Description: 
221020256235:Client was added as a Quick Add. 
The actual client and added him it automatically did program assignment of IR and he should have an AR program assignment

-- Resolution: Need to update subprogramkey to AR

-- Category/ Module: Case Management
-- Root cause: Code Error - DB Script fixed in the SP
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

*/

select activeflag, subprogramkey, * from personprogramarea
where personprogramid = '09b5ed17-3081-41d3-a83b-833868e8ffc4' and activeflag = 1;

update 	personprogramarea
set		subprogramkey = 'AR',
		updatedby = 'CDM-25485',
		updatedon = now()
where 	personprogramid = '09b5ed17-3081-41d3-a83b-833868e8ffc4' and activeflag = 1;
