/*
   Issue Description: CDM-14693
   Category/ Module  : Placement history  
   Root cause: User requested to remove records
   Pull request# for code fix: 4329
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/



update placement p set activeflag  = 0 where placementid = '503ab696-d522-4c16-80f7-8467bbbf65f6' and activeflag = 1;