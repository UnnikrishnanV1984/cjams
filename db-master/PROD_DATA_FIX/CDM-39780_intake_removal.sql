/*
   Issue Description: CDM-39780
   Category/ Module  : Dashboard
   Root cause: User requested to delete intake referral.
   Fix: removed intake from all the tables
*/

update intakedastaging 
set activeflag=0, updatedby='CDM-39780', updatedon=now()
where intakenumber='I241012601357' and activeflag=1;

update intakedastatus 
set activeflag=0, updatedby='CDM-39780', updatedon=now()
where intakenumber='I241012601357' and activeflag=1;

update intakesnapshot 
set activeflag=0, updatedby='CDM-39780', updatedon=now()
where intakenumber='I241012601357' and activeflag=1;

update routing 
set activeflag=0, updatedby='CDM-39780', updatedon=now()
where objectid='I241012601357' and activeflag=1;