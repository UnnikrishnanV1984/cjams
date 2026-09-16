/*
   Issue Description: CDM-18644 - Approved cases are displayed under pending case approval
   Category/ Module  : Approved inbox - Case pending
   Root cause:
   Pull request# for code fix: 4190
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


--rows affected =1 
update ROUTING set activeflag = 0 , updatedby = 'CDM-18644', updatedon = now() where routingid = 'e2de06e8-d165-42cc-97fa-87bf5563734c' and routingstatustypeid = 15 and activeflag = 1;
-- rows affected = 3
update ROUTING set activeflag = 0 , updatedby = 'CDM-18644', updatedon = now() where objectid = '30bb9758-e649-404e-9dce-52bc31513f98'  and routingstatustypeid = 15 
and activeflag = 1 and eventcode  = 'YTP'; 