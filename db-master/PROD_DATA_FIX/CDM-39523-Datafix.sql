/*
   Issue Description: CDM- 39523
   Category/ Module  : stuck approvals - delete
   Root cause: delete Case Pending Approval box
   Pull request# for code fix: 
   Reason why no related code fix: 
    requested a data fix to resolve
*/

update routing set activeflag =0,updatedby ='39523',updatedon =now()
where servicerequestnumber ='3281475' and objectid ='2d53bae0-8f12-4d64-888a-372547a2d3a8'
and routingstatustypeid =15 and activeflag =1;

update routing set activeflag =0,updatedby ='39523',updatedon =now()
where servicerequestnumber ='3078356' and objectid ='4035760c-1027-457e-acd9-8b6638d0e31e'
and routingstatustypeid =15 and activeflag =1;