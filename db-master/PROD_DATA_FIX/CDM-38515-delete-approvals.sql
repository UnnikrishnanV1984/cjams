/*
   Issue Description: CDM-38515 case plan that cannot be approved
      Category/ Module  :delete approval inbox
   Root cause: CDM-38515: Delete case pending for approval from supervisor Dashboard as it is already approved
   Fix Provided: Data fix to remove case from pending approval inbox
*/


  
update routing 
set 
	activeflag = 0,
	updatedby = 'CDM-38515',
	updatedon = now()
where routingid = '0f9dbd56-8039-484e-abd6-659ec4b2dbac';