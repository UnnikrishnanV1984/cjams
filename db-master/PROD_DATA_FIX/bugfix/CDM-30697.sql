/*
   Issue Description: CDM-30697
   Category/ Module  : intake
   Root cause: user wants Change the JURISDICTION from 'Fredrick' to ' Calvert'
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

  
update intakesnapshot set  jsondata = replace(jsondata::text, 'd0a6f218-4dee-45c3-b842-be7446a5ef41', 'b0ca6422-8241-4d86-bfef-51c7225de2fc')::jsonb 
 WHERE intakenumber = 'I231010582415' AND activeflag = 1;