-- CDM-27366 - FC Milestone - Data Issue
/*
-- Issue Description: 
   1) Case Assignments with Family Responsibility having associated Child name
   2) Case with Multiple active Family Responsibilities

-- Category/ Module: Adoption (Case Management) 
-- Root cause: User error 
-- Fix Provided:
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Case Number : 221030016973 -c95a1c0d-bbf8-4902-8d88-ba378e2bc418
-- Baltimore City	Family Services #5	Antwan Chambers	Tynisha Sewell (200015897)	Family	12/05/2022		
-- Baltimore City	Intake & Assessment #7	Shimekia Covell	Kayla Smith (200833153)	Family	12/07/2022

-- Before
select startdate, enddate, objectid, objecttypekey, activeflag, updatedby, updatedon	
from caseassignment 
where objectid = 'c95a1c0d-bbf8-4902-8d88-ba378e2bc418'
	and activeflag  = 1
	and responsibilitytypekey  = 'family'
	and enddate is null ;

-- update end date as 2022-12-07 07:41:48
select startdate, enddate, objectid, objecttypekey, activeflag, updatedby, updatedon	
	from caseassignment 
where caseassignmentid = '3463e9f0-d2b6-4e98-9873-805016d63fe1'
	and activeflag = 1 ;

update caseassignment
set enddate = '2022-12-07 07:41:48',
	updatedby = 'CDM-24734', 
	updatedon = now() 
where caseassignmentid = '3463e9f0-d2b6-4e98-9873-805016d63fe1'
	and activeflag = 1 ;

-- After 
select responsibilitytypekey, startdate, enddate, objectid, objecttypekey, activeflag, updatedby, updatedon 	from caseassignment 
where objectid = 'c95a1c0d-bbf8-4902-8d88-ba378e2bc418'
	and activeflag  = 1
	and responsibilitytypekey  = 'family'
	and enddate is null ;
	

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
	updatedby = 'CDM-24734', 
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
