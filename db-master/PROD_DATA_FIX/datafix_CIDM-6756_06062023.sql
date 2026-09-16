-- CIDM-6756 - Is it possible to have for Family responsibility(Family worker assignment ) code child assigned?
/*
-- Issue Description: 
      Family responsibility(Family worker assignment ) code child assigned
   
-- Category/ Module: Adoption (Case Management) 
-- Root cause: CJAMS application code issue.
-- Fix Provided: Datafix has been promoted to fix all impacted Family assignments having associated Child name 
--				 Code fix was provided to prevent adding clients for Family responsibility assignments at SP level.
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
	updatedby = 'CIDM-6756', 
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