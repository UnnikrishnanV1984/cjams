/*
Category/Module: Overdue Reason
Root cause:Data Entry error and user requested to update the overdue reason for Contact with Alleged Victim Completed : Alleged victim Unavailable & Family was contacted but unavailable to meet within mandate and also requested to update comments
Fix provided: Data fix to update the over due reason as Contact with Alleged Victim Completed : Alleged victim Unavailable & Family was contacted but unavailable to meet within mandate and also requested to update comments
Is Code fix Required?: NO
Code fix ticket#: N/A 
Reason why no related code fix: User error
*/


update cpsresponsetimeractions
set cpsresponsetimerreason1='VAVU', 
	cpsresponsetimerreason2='VFCM', 
	caseworkercomments='Ms. Reyes was not able to meet before the deadline due to work. Worker entered initial contact note incorrectly. She contacted the family on 5/28 at 1143am',
	updatedby='CJAMS-69463', 
	updatedon=now()
where cpsresponsetimeractionsid='57fa4ae4-76ce-48c8-820a-03cda1be16aa' and activeflag=1;