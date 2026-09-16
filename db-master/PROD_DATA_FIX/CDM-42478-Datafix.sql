/*
  Issue Description:  CDM-42478
   Category/ Module  :  Approval
   Root cause: Data fix done to remove the respective case plan approval request from the supervisor dashboard
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

update routing 
set activeflag = 0, updatedby = 'CDM-42478' , updatedon = now()
where objectid = '267d0983-04cc-422e-b7bc-fcd73d2543b1' and eventcode = 'CPLAN2' and routingstatustypeid = 15 and activeflag = 1;