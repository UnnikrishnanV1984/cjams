/*
   Issue Description: CDM-18198
   Category/ Module  : gap approval
   Root cause: gap approval pending
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update routing set activeflag =0, updatedby = 'CDM-18198', updatedon = now() where routingid = '208b4342-063f-4ea6-af5c-d2f439d0077f' and activeflag =1 and routingstatustypeid =15;

update routing set activeflag =0, updatedby = 'CDM-18198', updatedon = now() where routingid = 'fe082e91-06b3-427f-83cd-39fbadcfd967' and activeflag =1 and routingstatustypeid =15;