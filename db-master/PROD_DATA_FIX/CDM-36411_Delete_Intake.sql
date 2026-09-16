/*
 Issue Description: CDM-36411
 Category/ Module : Intake
 Root cause: I221010248072, user requested to delete the intake.
 Fix: Deleted the intake from intakedasstaging, intakedastatus tables, no records are found in intakeservrequest, routing and intakesnapshot tables.
 Pull request# for code fix: 
 Reason why no related code fix: 
 Status of the code fix if already submitted and expected prod fix date: 
 Need to do data fix
 */
-- Intakestatus and Intakedasstaging tables
select
    *
from
    intakedastatus
where
    intakenumber in ('I221010248072')
    and activeflag = 1;

update
    intakedastatus
set
    activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-36411'
where
    intakenumber in ('I221010248072')
    and activeflag = 1;

select
    *
from
    intakedastaging
where
    intakenumber in ('I221010248072')
    and activeflag = 1;

update
    intakedastaging
set
    activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-36411'
where
    intakenumber in ('I221010248072')
    and activeflag = 1;

--- No records found from the below tables to delete
select
    *
from
    intakesnapshot
where
    intakenumber in ('I221010248072');

select
    *
from
    intakeservicerequest
where
    intakenumber = 'I221010248072';

select
    *
from
    routing
where
    objectid = 'I221010248072';