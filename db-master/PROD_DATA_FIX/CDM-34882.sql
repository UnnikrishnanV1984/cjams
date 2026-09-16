/*
 * CDM-34882 - need deletion
 * Customer Email ID:melisha.harris1@maryland.gov
 * Customer Name:Melisha Harris
 * Focus Area:Persons: Others
 * Description - I202100225217:The referral is not active
 * remove the intake # I202100225217 as requested.
 * 
 * 
*/


update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-34882'
where objectid in('I202100225217');

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-34882'
where intakenumber in('I202100225217');

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-34882'
where intakenumber in('I202100225217');

update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-34882'
where intakenumber in('I202100225217');