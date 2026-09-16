/*
 Issue Description:CDM-41575
 Category/ Module: delete intakes I241012853438,I202000561939,I231010372008 Old/incorrect intake 
 needs to be deleted from user Rosa Ferro De Molinari
 Root cause: delete intakes I241012853438,I202000561939,I231010372008
 Pull request# N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/

/*
select *from routing where objectid in ('I241012853438','I202000561939','I231010372008') and activeflag=1;
select *from intakedastatus where intakenumber in ('I241012853438','I202000561939','I231010372008') and activeflag=1;
select *from intakedastaging where intakenumber in ('I241012853438','I202000561939','I231010372008') and activeflag=1;
select *from intakesnapshot where intakenumber in ('I241012853438','I202000561939','I231010372008') and activeflag=1;
*/


update routing 
set activeflag=0,updatedon=now(),updatedby='CDM-41575'
where objectid in ('I241012853438','I202000561939','I231010372008') and activeflag=1;

update intakedastatus 
set activeflag=0,updatedon=now(),updatedby='CDM-41575'
where intakenumber in ('I241012853438','I202000561939','I231010372008') and activeflag=1;

update intakedastaging 
set activeflag=0,updatedon=now(),updatedby='CDM-41575'
where intakenumber in ('I241012853438','I202000561939','I231010372008') and activeflag=1;

update intakesnapshot 
set activeflag=0,updatedon=now(),updatedby='CDM-41575'
where intakenumber in ('I241012853438','I202000561939','I231010372008') and activeflag=1;