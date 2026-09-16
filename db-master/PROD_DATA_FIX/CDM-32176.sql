/*
   Issue Description: CDM-32176
   Category/ Module  : 
   Root cause: user want unable to see in completed tab case #221020250172 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    . Need to do data fix
*/ 
update intakeservicerequest set isrouted=true,updatedby='CDM-32176',updatedon=now() 
where intakeserviceid='9e7b09b6-4c50-4959-ae6c-ac151c2be0ea';
