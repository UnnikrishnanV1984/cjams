/*
   Issue Description: CJAMS-66182
   Category/ Module  : Approval
   Root cause: User Request, Requested to remove case from supervisor dashboard.
   Fix provided: Data fix is done is remove to case from supervisor dashboard 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/




update routing
set activeflag = 0,
	updatedby = 'CJAMS-66182',
	updatedon = now()
where routingid ='863b125e-6468-4975-b8a8-c59074f2be5b'
	and routingstatustypeid = 15
	and activeflag = 1 ;