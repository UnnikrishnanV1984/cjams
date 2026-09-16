/*
   Issue Description: CDM-41338
   Category/ Module  : Placement
   Root cause: user requested to add CPA home, incorrect provided id added earlier.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


  update cjams.placementcpahomes 
  set altproviderid  ='6098285', updatets = now()
  where placementcpahomeid = 'fb981bfd-9fe2-4b13-99db-45fed02ba5f0' 
        and placementid = 'bc9cbfd0-e9cb-42a7-b266-76eebcdb2645';
