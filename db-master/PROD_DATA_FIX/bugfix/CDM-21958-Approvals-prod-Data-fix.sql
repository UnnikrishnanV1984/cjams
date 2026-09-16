/*
 Issue Description:CDM-21958
 Category/ Module:delete purchase auth
 Root cause: delete purchase auth
 Pull request# N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/

--case plan 
update routing 
	set
	activeflag = 0,
	updatedon = now(),
	updatedby = 'CDM-21958'
	where routingid ='9ef18af4-14f2-4cf0-8773-30b23bc7f4b7';
