/*
   Issue Description: CIDM-8697
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update person set activeflag =9
 where cjamspid in (
     select cjamspid from person where activeflag = 1 group by cjamspid having count(*) > 1
 );