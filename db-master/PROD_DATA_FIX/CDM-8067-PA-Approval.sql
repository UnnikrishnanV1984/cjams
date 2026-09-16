/*

   Issue Description: CDM-8067 -Payment not being approved
   Category/ Module  :  Purcahse authorization
   Root cause: CHESSIE migratoin issue for teamid
   Pull request# for code fix: NA
   Reason why no related code fix: NA
   Status of the code fix if already submitted and expected prod fix date: NA
   Old value: teamid:3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a
**/
update routing set teamid='31669792-e3c1-40f8-be61-27b2e0c0aa5c',updatedby='CDM-8067',updatedon=now() where objectid=756851 and routingstatustypeid=39 
and routingid='c742f292-234f-43ff-9b43-f8ff5f4c21f8';