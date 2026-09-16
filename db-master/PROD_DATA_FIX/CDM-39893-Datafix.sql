/*
   Issue Description: CDM- 39893
   Category/ Module  : stuck approvals - delete
   Root cause: delete Case Pending Approval box
   Pull request# for code fix: 
   Reason why no related code fix: 
    requested a data fix to resolve
*/

update routing set activeflag =0,updatedby ='39893',updatedon =now()
where servicerequestnumber ='3286658' and objectid ='73cc55b1-97ec-4fc8-8d0b-532a17036e92'
and routingstatustypeid =15 and activeflag =1;

update routing set activeflag =0,updatedby ='39893',updatedon =now()
where servicerequestnumber ='3174207' and objectid ='00993931-4df0-424a-a6da-daa1d6cc5f09'
and routingstatustypeid =15 and activeflag =1;

update routing set activeflag =0,updatedby ='39893',updatedon =now()
where servicerequestnumber ='3219307' and objectid ='683ade1e-7fce-468b-ad6d-7e44641378f3'
and routingstatustypeid =15 and activeflag =1;

update routing set activeflag =0,updatedby ='39893',updatedon =now()
where servicerequestnumber ='3176165' and objectid ='cfc897e7-b901-4776-9185-c38f800e79af'
and routingstatustypeid =15 and activeflag =1;