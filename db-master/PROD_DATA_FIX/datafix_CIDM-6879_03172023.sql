-- CIDM-6879 - Family Assignment should not hold a Child ID Associated. Need a One time Bulk Data Fix
/*
-- Issue Description: 
   Case Assignments with Family Responsibility having associated Child name
   
-- Category/ Module: Adoption (Case Management) 
-- Root cause: CJAMS application was having a flaw in code.
-- Fix Provided: Code fix was provided with CIDM-6756 and this is a One time Bulk Data Fix.
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
	updatedby = 'CIDM-6879', 
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