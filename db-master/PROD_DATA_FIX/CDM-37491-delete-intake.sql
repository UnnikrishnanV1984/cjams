-- CDM-37491 - Delete intake
/* Issue Description:User requested to delete intake, it was entered by mistake

-- Intake case number: I231011568928

-- Category/ Module: Decision

-- Root cause: User requested to delete intake, it was entered by mistake #I231011568928
-- Fix Provided: Datafix has been provided to delete intake
-- Pull request# N/A

*/


select activeflag, * from intakedastatus where intakenumber='I231011568928' and activeflag =1;

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-37491'
where intakenumber = 'I231011568928' and activeflag =1;

select activeflag, * from intakedastaging where intakenumber='I231011568928' and activeflag =1;

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-37491'
where intakenumber = 'I231011568928' and activeflag =1;	

