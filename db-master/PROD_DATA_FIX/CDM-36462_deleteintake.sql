-- CDM-36462 - CW intake
/* Issue Description:User requested to delete intake, it was entered by mistake

-- Intake case number: I241011940932

-- Category/ Module: Decision

-- Root cause: User requested to delete intake, it was entered by mistake #I241011940932
-- Fix Provided: Datafix has been provided to delete intake
-- Pull request# N/A

*/

select * from routing where objectid in ('I241011940932');

select * from intakedastatus where intakenumber='I241011940932' and activeflag =1;

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-36462'
where intakenumber = 'I241011940932' and activeflag =1;

select * from intakedastaging where intakenumber='I241011940932' and activeflag =1;

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-36462'
where intakenumber = 'I241011940932' and activeflag =1;	

select * from intakesnapshot where intakenumber='I241011940932';

