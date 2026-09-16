/*
Issue Description: CJAMS-69446 - Response Timer showing wrong overdue reason
Category/Module: Overdue Reason
Root cause: Data Entry error, the user picked Data entry error but face to face met mandate and requested to
   update the overdue reason to Emergency situation prevented initial contact > Non-work related emergency
Fix provided: Data fix to update the over due reason as Emergency situation prevented initial contact >
   Non-work related emergency
Regression Impacts: N/A
Is Code fix Required?: NO
Code fix ticket#: N/A
Reason why no related code fix: User error
*/

update cpsresponsetimeractions
set cpsresponsetimerreason1='VEPC',
	cpsresponsetimerreason2='VNEC',
	reason=null,
	updatedby='CJAMS-69446',
	updatedon=now()
where cpsresponsetimeractionsid='952e9900-a01a-4957-b22e-b2502e1c255c' and activeflag=1;