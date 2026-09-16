/*
   Issue Description: CDM-26406
   Category/ Module  : need to delete persons
   Root cause: user wants to remove
   Pull request# for code fix: 
  explanantion: user wants to remove
  */


update
    cjams.actor
set
    activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-26406'
where
    actorid = 'c34db52f-59da-46d1-a77e-e520f15c9477';


update
    cjams.intakeservicerequestactor
set
    activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-26406'
where
    intakeservicerequestactorid = 'c85544bd-8790-455e-9da6-881244017929';


update
    cjams.personrole
set
    activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-26406'
where
    personid = '7c16f3e6-b284-495b-aa95-3fddc5f28ba3'
    and intakeserviceid = '6ad62e88-a107-4f92-a4bf-1a6742f1fe85';

update
    cjams.actorrelationship
set
    activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-26406'
where
    actorrelationshipid in (
        '7a38b118-a87f-4953-96aa-66ef7e2a2b3c',
        '74db2d8a-f1d4-42bc-baae-a794399e2316',
        '0fc082cd-ef1a-474d-93b3-29d4d395212c'
    );

update
    personprogramarea
set
    activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-26406'
where
    personprogramid = 'ac17be74-f438-4506-bdbe-c382efb5ccb5';

update
    cjams.contactparticipant
set
    activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-26406'
where
    contactparticipantid = '832926cc-844a-452d-9369-804e1048a069'
    and intakeservicerequestactorid = 'c85544bd-8790-455e-9da6-881244017929';
