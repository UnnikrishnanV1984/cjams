/*
   Issue Description: CDM-30559
   Category/ Module  : Safe c Assessment
   Root cause: user requested to change the status of the safe c assessment approved in error
   Pull request# for code fix: 8804
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Data fix is required.
*/
update assessment set assessmentstatustypekey = 'Rejected', updatedon = now(), 
	updatedby = 'ffaff6c5-0784-47e8-b29e-a04373e6cc89' 
where assessmentid = '3e2ac457-d2ce-4942-98b1-1e0f4d4a0502';