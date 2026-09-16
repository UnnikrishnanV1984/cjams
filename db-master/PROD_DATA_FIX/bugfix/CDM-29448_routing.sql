/*
   Issue Description: CDM-29448
   Category/ Module  : Approval Inbox
   Root cause: case plan records already approved.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
update routing 
set activeflag = 0, updatedby = 'CDM-29448' , updatedon = now()
where objectid = '7076d3d0-7160-4c74-8ce9-1932a826b474' and eventcode = 'CPLAN2' and routingstatustypeid = 15 and activeflag = 1;