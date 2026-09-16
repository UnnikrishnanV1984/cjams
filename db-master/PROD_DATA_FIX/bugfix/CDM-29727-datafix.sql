/*
   Issue Description: CDM-29727
   Category/ Module  : Removal of Service case from approval inbox
   Root cause:Please remove case from my inbox.
   Pull request# for code fix: It's a data fix
   Reason why no related code fix:  
   
*/

update routing set activeflag = 0, updatedby = 'CDM-29727', updatedon = now() 
where routingid = 'e104767e-43b2-46e1-a2d1-a7e64d3330ae' 
and activeflag  = '1' and routingstatustypeid='15';