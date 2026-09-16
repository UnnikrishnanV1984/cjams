-- CDM-28596 - Information disappeared
/*
-- Issue Description: 
	The Client 200924024 Leo Johnson is missing from the service case 202109507053.

-- Case ID: 202109507053 - b745cea1-c049-4529-adc8-f892cb3c29f9
-- Client ID: 200924024 (Leo Johnson) - 60bbf37f-3399-414d-9ead-44447c0f7e02

-- Auth ID: 1841062 - 2022-07-06 To 2022-08-06 - $1750.00
-- Provider ID: 5034345	(Calvin B Scruggs Funeral Home)
-- Service: Burial Assistance (Paid)
-- Forwarded to Funding Approval

-- Category/ Module: Person (Investigation Management)
-- Root cause: Under this Service case this person is not having record with primary role as true (intakeservicerequestactor table Data Issue)
-- Fix Provided: Datafuis has been promoted to fix the intakeservicerequestactor table Data Issue.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

select servicecaseid, isprimary, intakeserviceid, activeflag, updatedby, updatedon
	from intakeservicerequestactor
where intakeservicerequestactorid = '4bb034b8-08cd-483a-8116-3586964b68ab'
	and activeflag = 1 ;

-- isprimary = true
update intakeservicerequestactor
set servicecaseid = 'b745cea1-c049-4529-adc8-f892cb3c29f9', -- 202109507053
	updatedby = 'CDM-28596',
	updatedon = now()
where intakeservicerequestactorid = '4bb034b8-08cd-483a-8116-3586964b68ab'
	and activeflag = 1 ;