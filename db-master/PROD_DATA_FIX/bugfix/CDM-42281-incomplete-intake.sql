/*
 * CDM-42281 - As requested by user, intake was deleted
 * Customer Email ID: marjuin.massalee@maryland.gov
 * Description - Intake was removed from workers dashboard and workload search.
 * 
 */

-- select * from intakedastatus where intakenumber='I241013143314';

-- select * from intakedastaging where intakenumber='I241013143314';

update intakedastatus
set activeflag=0, updatedby='CDM-42281', updatedon=now()
where intakenumber='I241013143314';

update intakedastaging
set activeflag=0, updatedby='CDM-42281', updatedon=now()
where intakenumber='I241013143314';