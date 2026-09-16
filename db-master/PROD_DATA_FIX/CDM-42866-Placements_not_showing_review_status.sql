/*
  Issue Description:  CDM-42866
   Category/ Module  :  Placement
   Root cause: toroleid value was null in DB leading to fail to fetch the routingstatus from function getplacementbyservicecase 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/
update routing 
set toroleid = 'CWSP',
	updatedby = 'CDM-42866',
	updatedon = now()
where routingid in (
	select  routingid  
	from routing 
	where eventcode = 'PLTR'
	and toroleid is null
	and routingstatustypeid = 15
	and activeflag = 1
)