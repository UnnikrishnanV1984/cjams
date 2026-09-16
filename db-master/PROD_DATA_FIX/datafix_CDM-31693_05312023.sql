-- CDM-31693 - Multiple active Family assignments for the same Service case
/*
-- Issue Description: 
      Multiple active Family assignments for the same case
   
-- Category/ Module: Adoption (Case Management) 
-- Root cause: CJAMS application code issue.
-- Fix Provided: Code fix was provided to prevent creating multiple active family case assignments at SP elevel.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Generic Datafix to fix all Case Assignments with Family & Administrative having associated Child name
-- Before
select caseassignmentactorid, activeflag, updatedby, updatedon 
	from caseassignmentactor
where activeflag = 1
	and caseassignmentid  
		in ( select caseassignmentid 
				from caseassignment 
			 where activeflag = 1
				and responsibilitytypekey in ('family', 'administrative')
				and etl_userid is null 
				and old_id is null 
			) ;

update caseassignmentactor
set activeflag = 0,
	updatedby = 'CDM-31693', 
	updatedon = now() 
where activeflag  = 1
	and caseassignmentid  
		in ( select caseassignmentid 
				from caseassignment 
			 where activeflag = 1
				and responsibilitytypekey in ('family', 'administrative')
				and etl_userid is null 
				and old_id is null 
			) ;

-- After
select caseassignmentactorid, activeflag, updatedby, updatedon 
	from caseassignmentactor
where activeflag = 1
	and caseassignmentid  
		in ( select caseassignmentid 
				from caseassignment 
			 where activeflag = 1
				and responsibilitytypekey in ('family', 'administrative')
				and etl_userid is null 
				and old_id is null 
			) ;