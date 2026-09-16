/*
   Issue Description: CJAMS-66422
   Category/ Module  : data fix to revert the supervisor decision for intake#I261013958371
   Root cause: user requested to revert the supervisor decision for intake#I261013958371
   Fix provided: Data fixd is done to revrt the supervisor decision so that they can goaahead and approve the intake which
                 should allow them to create a case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update routing
set updatedby = 'a5ea28ad-963f-434c-a06c-7cd5b3884acc', 
updatedon = now(), routingstatustypeid  = 1, supervisordecision = null, insertedon='2026-03-23 11:49:29'
 where objectid = 'I261013958371' and activeflag = 1;


update intakedastatus
set updatedby = 'CJAMS-66422', 
       updatedon = now(), status = 1
where intakenumber = 'I261013958371';

update intakedastaging
set
  updatedby = 'CJAMS-66422',
  updatedon = now(),
  status = 'pending',
  ispreintake = FALSE
where intakenumber = 'I261013958371' and activeflag = 1;

update intakesnapshot
set
  updatedby = 'CJAMS-66422', 
  updatedon = now(), 
  activeflag = 0
where intakenumber = 'I261013958371' and activeflag = 1;