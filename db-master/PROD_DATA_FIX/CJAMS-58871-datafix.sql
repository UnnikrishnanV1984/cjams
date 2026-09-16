/*
 Issue Description:
 Cornelius Callier role as financial supervisor wasn't populating in the financial approval supervisor name.
 Category/ Module: Placement
 Root cause: Wrong teamtypekey was assigned to user.
 Pull request# 	N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/
--select teamtypekey ,* from userprofile u where securityusersid  = 'c0554606-08dc-4495-96d5-7dd039217244'
update userprofile 
set teamtypekey = 'FNS',
	updatedby = 'CJAMS-58871',
	updatedon = now()
where securityusersid = 'c0554606-08dc-4495-96d5-7dd039217244' 
and activeflag =1;