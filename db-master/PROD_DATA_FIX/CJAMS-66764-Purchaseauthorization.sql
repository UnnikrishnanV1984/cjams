/*
   Issue Description: CJAMS-66764-service log pending
   Category/ Module  : Purchase Authorization
   Root cause: Requested to re direct to the new Asst Director  as the previous director is no more working
   Fix provided: Data fix is done to redirect to melinda baldwin
   Pull request# for code fix:
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update routing set tosecurityusersid='6f9d10f6-2055-4ffb-8667-1b8b84b11ec2',updatedby='CJAMS-66764',updatedon=now()
WHERE routingid='ae69b359-28f4-4b32-81a4-135c76f7a715';