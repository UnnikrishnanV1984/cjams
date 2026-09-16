/*
 * CDM-35434 - intake won't delete
 * Customer Email ID:monica.kiefer3@maryland.gov
 * Customer Name:Monica Kiefer
 * Focus Area:Assignments
 * remove two Intakes that appear in the Intake Pending dashboard as those two were an old intakes.
 * I211010208342
 * I221010242451
*/


update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-35434'
where objectid in ('I211010208342','I221010242451');;

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-35434'
where intakenumber in ('I211010208342','I221010242451');;

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-35434'
where intakenumber in ('I211010208342','I221010242451');;

update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-35434'
where intakenumber in ('I211010208342','I221010242451');;
