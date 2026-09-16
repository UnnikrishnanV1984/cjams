-- CDM-35747 - Case Closure
/* Issue Description:In Assignment Screen End Date is not displayed for #231020456183

-- ServiceCase ID: c5184807-dce0-47f2-af38-d03490c816f0

-- Category/ Module: Assignment 

-- Root cause: In Assignment Screen End Date is not displayed for #231020456183
-- Fix Provided: Datafix has been provided to update end date on assignment for c5184807-dce0-47f2-af38-d03490c816f0
-- Pull request# N/A

*/
select enddate,* from caseassignment 
WHERE objectid = 'c5184807-dce0-47f2-af38-d03490c816f0' and objecttypekey not in ('intake') and activeflag = 1;

update caseassignment
set enddate='2023-10-18 00:00:00',
	updatedon = now(), 	
	updatedby = 'CDM-35747'
WHERE objectid = 'c5184807-dce0-47f2-af38-d03490c816f0' and objecttypekey not in ('intake') and activeflag = 1; 