/*
   Issue Description: CDM-31887
   Category/ Module  : 
   Root cause: user want to remove intake from pending dashboard
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    . Need to do data fix
*/ 
update routing set eventcode='INTR' where routingid='ff1f4f07-cd07-4e95-b440-ba40c09cd996';
update intakedastaging  set status='Complete' where intakenumber='I231010611335' and activeflag=1;