/*
-- CDM-36438 - Intake Deletion
-- Issue Description: Dashboard:I221010353445 - Old intake that needs to be taken off of Diane Marshalls cjams workload. This is an intake that was entered into the Adult Services program area of cjams.
-- Case ID: S2024011056175
-- Category / Module: CW / Intake
-- Root cause: I221010353445, user requested to delete the intake.
-- Fix Provided:  Deleted the intake from intakedasstaging, intakedastatus and intakeservrequestactor tables.
		  No records are found in intakesnapshot, intakeservrequest and routing tables. # S2024011056175
-- Pull Request# N/A
*/

select * from intakedastatus where intakenumber in ('I221010353445') and activeflag = 1;

update intakedastatus
set	activeflag = 0, updatedon = now(), updatedby = 'CDM-36438'
where intakenumber in ('I221010353445') and activeflag = 1;

select * from intakedastaging where intakenumber in ('I221010353445') and activeflag = 1;
	
update intakedastaging
set activeflag = 0, updatedon = now(), updatedby = 'CDM-36438'
where intakenumber in ('I221010353445') and activeflag = 1;

-- No records found in the below table for intakenumber I221010353445
select * from intakesnapshot where intakenumber in ('I221010353445');

-- No records found in the below table for intakenumber I221010353445
select * from intakeservicerequest where intakenumber = 'I221010353445';
	
-- intakeserviceid is null in this table
select * from intakeservicerequestactor where intakeservicerequestactorid = 'b86a1188-a3c0-47e8-9202-51b66069bb93';

update intakeservicerequestactor
set activeflag = 0, updatedon = now(), updatedby = 'CDM-36438'
where intakeservicerequestactorid = 'b86a1188-a3c0-47e8-9202-51b66069bb93' and activeflag = 1;
		
-- No records found in the below table for intakenumber I221010353445
select * from routing where objectid = 'I221010353445';
		
