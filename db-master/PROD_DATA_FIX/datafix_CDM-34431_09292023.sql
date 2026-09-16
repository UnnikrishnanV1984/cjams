-- CDM-34431 - System Adjustments
/*
-- Issue Description: 
	2 system adjustments that rolled over the D365 but the case is not a Worcester County case. 
    The case worker assigned to the case is Baltimore City.
	
	User request to delete the wrong Worcester County case assignment.
   
-- Case ID: 3212313
-- Client ID: 3354460 (ELIJAH BYRD) - 8ff1d37f-9af5-4605-a437-b988888bc4eb
-- Provider ID: 5067709	(Patricia Byrd)
-- Worcester county Payments
-- GAP Payment ID: 3679276 - Detial ID: 4915583 - System Adjustment - July 2023 Services
-- GAP Payment ID: 3679277 - Detial ID: 4915584 - System Adjustment - August 2023 Services
   
-- Category/ Module: Placement (Case Management) 
-- Root cause: Service case is with Baltimore City and user created wrong Family assignmment for Worcester County.    
-- Fix Provided: Datafix has been promoted to remove the Worcester County Family assignmment.
-- Verified in the last database copy of MD CHESSIE that case did not have any clients involved.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To remove the Worcester County Family assignmment. (CDM-34431)
-- Assigned to Worcester County user Althenia Jolley
select objectid, objecttypekey, responsibilitytypekey, startdate, enddate, toworkeridno, updatedby, updatedon 
	from caseassignment
where caseassignmentid = '0ed80a61-b45f-4f90-9777-64f9891ed8f2'
	and activeflag = 1 ;

update caseassignment
set activeflag = 0, 
	updatedby = 'CDM-34431',
	updatedon = now() 
where caseassignmentid = '0ed80a61-b45f-4f90-9777-64f9891ed8f2'
	and activeflag = 1 ;

