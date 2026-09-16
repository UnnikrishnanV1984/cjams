/*
Issue Description: 3121193:On the FC milestone run on 4/22/25. This placement is not showing on the report for this child 3681898 
Category/Module: routing table
Root cause: default superviosor wasn't updated on the userprofile
Fix provided: provided datafix to update the userprofile and routing table to route to correct user.
Code fix ticket#:N/A
Reason why no related code fix: Status of the code fix already submitted
Status of the code fix if already submitted and expected prod fix date: N/A
Backup before update/ delete:
*/
update routing 
set tosecurityusersid = '9b057c26-9c53-4aeb-b375-d6feb535a53f',
	updatedby = 'CJAMS-59193',
	toroleid = 'CWSP',
	updatedon = now()
where routingid = '79278df4-0326-4585-99fa-f0f16afce932'
and objectid = 'c24c5962-c0bf-4e04-9243-50affd222115' and activeflag = 1;

update userprofile
set supervisorid = '9b057c26-9c53-4aeb-b375-d6feb535a53f',
	updatedby = 'CJAMS-59193',
	updatedon = now()
where securityusersid = '53adb63f-3406-45b7-8ae5-35216ecb03c2' and activeflag = 1;