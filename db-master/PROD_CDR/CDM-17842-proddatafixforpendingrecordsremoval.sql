
/*
   Issue Description: CDM-17842
   Category/ Module  :  Removing Case plan pending records
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update routing set activeflag = 0, updatedon = now(), updatedby ='CDM-17842' where objectid in ('520e69cd-8d55-4b23-be83-0b9cc2480f9a','3a5a8329-fb85-4206-88cb-5764e18bc235') and eventcode = 'CPLAN2' and routingstatustypeid = 15;
