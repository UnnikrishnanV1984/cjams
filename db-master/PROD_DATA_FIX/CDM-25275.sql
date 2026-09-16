/*
   Issue Description: CDM-25275
   Category/ Module  : approval inbox 
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
--- Due to some glich these records not approved but those updated activeflag 0 checked with new senario it was working properly 

update cjams.routing set activeflag =1, updatedby='CDM-25275', updatedon =now()

where routingid in ('493178db-42c9-449d-9c32-7335648dcba8','7fbb0e59-a954-4100-9508-45e25072f93d')
