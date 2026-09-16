/*
   Issue Description: CIDM-10583
   Category/ Module  : data fix to revert the supervisor decision for intake#I251013308337
   Root cause: user requested to revert the supervisor decision for intake#I251013308337
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update routing
  set updatedby = '7e8941ee-bddb-4ce0-90a9-8a67a22d3165', 
      updatedon = now(), routingstatustypeid  = 1,
      supervisordecision = null
where objectid = 'I251013308337' and activeflag = 1;

update intakedastatus
   set updatedby = 'CIDM-10583', 
       updatedon = now(), status = 1
where intakenumber = 'I251013308337';

update intakedastaging
set
  updatedby = 'CIDM-10583',
  updatedon = now(),
  status = 'pending',
  ispreintake = FALSE
where intakenumber = 'I251013308337' and activeflag = 1;

update intakesnapshot
set
  updatedby = 'CIDM-10583', 
  updatedon = now(), 
  activeflag = 0
where intakenumber = 'I251013308337' and activeflag = 1;