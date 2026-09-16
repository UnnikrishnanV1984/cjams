/*
   Issue Description: CJAMS-60322
   Category/ Module : Data fix has been promoted to removed the case connect that was submitted by the worker from the dashboard
   Root cause: As per system design, once the case connect that was submitted by the worker it cannot be removed from UI. 
        So, user requested to remove through data fix
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update routing
  set activeflag = 0,
      updatedby = 'CJAMS-60322',
      updatedon = now()
where objectid = '13f01594-ec8c-488b-b007-0fc96fe91c3a' 
  and routingid = '0ce12778-c61b-46d9-8e99-a143db87669f'
  and activeflag = 1;