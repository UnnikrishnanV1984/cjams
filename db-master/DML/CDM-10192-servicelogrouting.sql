/*
  Issue Description:  CDM-10192
   Category/ Module  :  Rerouting Service Log
   Root cause: User requested to reroute other user as actual user no longer with agency
   Pull request# for code fix: NA
   Reason why no related code fix: NA
   Status of the code fix if already submitted and expected prod fix date: 
Backkup: tosecurityusersid='9e9f9f17-2889-499f-a35b-ec0d8d9f24d6'
*/
update routing set tosecurityusersid='430aff8a-d3fd-4df8-9d09-9c539edeaf65',updatedby='CDM-10192',updatedon=now() where objectid=1762594 and routingstatustypeid=39;