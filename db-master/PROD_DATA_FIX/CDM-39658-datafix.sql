/*
  Issue Description:  CDM-39658
   Category/ Module  : Application  
   Root cause: Remove the pending approval list from the supervisor Joyce
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/


update routing
set activeflag = 0,
	updatedby = 'CDM-39658',
	updatedon = now()
where objectid ='0883f07d-5b38-44c9-a2c2-eba1192a1c5c' and routingid='66ddee0d-7c37-4106-a676-3923ab35be13'
	and eventcode = 'IHSA'
	and activeflag = 1 ;


update routing
set activeflag = 0,
	updatedby = 'CDM-39658',
	updatedon = now()
where objectid ='5d5ca372-19a4-4fc5-88b3-1ae429b49e36' and routingid='cc99c9de-50db-407d-9bd8-69ef79b71265'
	and eventcode = 'PPLR'
	and activeflag = 1 ;