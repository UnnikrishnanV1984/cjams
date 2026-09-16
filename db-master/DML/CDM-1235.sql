update servicecase
set statustypekey ='ASSGN',updatedby = 'Datafix user as per CDM-1235' , updatedon = now()
where servicecaseid='51be0076-d3b6-4899-87c1-6c6e2c8da434';

update routing 
set routingstatustypeid = 4, updatedby = 'Datafix user as per CDM-1235' , updatedon = now()
where routingid = 'c7703bae-09e3-49a9-9d00-c7b487aa1559';