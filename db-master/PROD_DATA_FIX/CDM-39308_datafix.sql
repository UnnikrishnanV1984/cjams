/*
   Issue Description: CDM-39308
   Category/ Module  : Assignments
   Root cause:Dashboard issues. Cases that were screened in by one screener, are coming up screened in under a different screener
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update routing set fromsecurityusersid ='5c823c45-b6c4-4486-b6b2-8bd7a21962b5' where objectid ='I241012414245' 
and eventcode ='INTR' and activeflag =1;