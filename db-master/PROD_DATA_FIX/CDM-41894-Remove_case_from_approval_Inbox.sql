/*
-- CDM-41894

-- Issue Description: 
  remove case from approval inbox dashboard tab as Case is already closed
  
-- Customer Email ID: charity.nzeadighibe@maryland.gov

-- Root cause: Data fix to set the activeflag
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/
update routing set activeflag = 0,
updatedby = 'CDM-41894',
updatedon = now()
where routingid = 'a00efd77-3956-49be-9539-815276b6cf8a' 
and servicerequestnumber = '3278893' 
and activeflag =1 
and objectid ='416bf295-fa8d-491a-b2df-89e7d2c3e190'
and routingstatustypeid = 15 and eventcode = 'YTP';