/*
   Issue Description: CDM-18194
   Category/ Module  :  Backlogged Approval
   Root cause: user wants pending approvals to be removed
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/



delete from routing where routingid ='e58c6c6c-b3da-4535-a315-3e771673a9ec' and routingstatustypeid =39 and activeflag=1 and objectid =1802118;

delete from routing where routingid ='d861cb18-710f-46e5-988b-80dc862b3f82' and routingstatustypeid =42 and activeflag=1 and objectid =1802118;

delete from routing where routingid ='c344d2cf-89be-4ec2-a768-f75ce93c7ef5' and routingstatustypeid =42 and activeflag=1 and objectid =1802118;


update routing set activeflag =0, updatedby = 'CDM-18194', updatedon = now() where routingid = 'c87fc934-49d0-4b29-8b6a-fc8e51117d36' and routingstatustypeid =15;

update routing set activeflag =0, updatedby = 'CDM-18194', updatedon = now() where routingid = 'b2e2a3b9-5208-44f2-ad90-b3599fef472a' and routingstatustypeid =15;

update routing set activeflag =0, updatedby = 'CDM-18194', updatedon = now() where routingid in ('5e5f88c5-6cbc-4ea4-821b-24ad9c4ca88f','9021b380-c0b1-4e1d-852f-d58f7877ed7c') and routingstatustypeid =15;

update routing set activeflag =0, updatedby = 'CDM-18194', updatedon = now() where routingid in ('bf79b590-33a9-4615-a67e-d570bb1e1934','340acc81-7738-4858-81c1-790cf723f68c') and routingstatustypeid =15;
