/*
   Issue Description: CDM-18761
   Category/ Module  : service log pending
   Root cause: service log pending for approval
   Pull request# for code fix: 
   Explanantion: user wants to delete the approval record which is already approved
*/


update routing set activeflag =0, updatedby = 'CDM-18761', updatedon = now() where routingid = '20090b61-deaa-46dd-8397-7ff5f58cbd9f' and routingstatustypeid =40;