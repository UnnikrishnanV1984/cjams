/*
-- Issue Description: CDM-40456
-- Category/ Module: Re-opening CPS case
-- Root cause: User closed case in error
-- Fix Provided: Datafix has been promoted to update the case.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


update intakeservicerequest 
    set exitdate = null,
    intakeserreqstatustypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690', 
    updatedon= NOW(), 
    updatedby='CDM-40500'
where intakeserviceid = '303980b6-9b6c-45ae-9883-510d23c07030';


update intakeservicerequestdispositioncode 
    set activeflag = 0, 
    updatedon= NOW(), 
    updatedby='CDM-40500'
where intakeservicerequestdispositioncodeid in ('0c046221-b93d-4eae-8e06-1f4ab7ce3255','2fcdeadb-d091-4707-b8b4-3b6a62dfba27');


update caseassignment 
set activeflag = 0,
 	updatedon= NOW(), 
    updatedby='CDM-40500'
where caseassignmentid = '535dee64-3721-4a5e-8248-10fc38c09053';


update caseassignment 
set enddate = null,
 	updatedon= NOW(), 
    updatedby='CDM-40500'
where caseassignmentid = '185af1f4-39d6-4b77-8db5-e1a709386042';


update personprogramarea 
set enddate = null,
 	updatedon= NOW(), 
    updatedby='CDM-40500'
where objectid = '303980b6-9b6c-45ae-9883-510d23c07030' and activeflag = 1;
