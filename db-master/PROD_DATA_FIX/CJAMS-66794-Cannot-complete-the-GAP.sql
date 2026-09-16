/*
   Issue Description: CJAMS-66794
   Category/ Module  : Prod data fix To remove the  REJECTED Gap application
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update  routing 
set activeflag = 0, updatedon = now(), updatedby = 'CJAMS-66794'
where objectid='b816518a-ec01-432d-b06d-f80d972dec36' and activeflag = 1 and routingstatustypeid = 17;