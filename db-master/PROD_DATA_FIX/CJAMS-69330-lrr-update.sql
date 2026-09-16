/*
Category/Module: Overdue Reason
Root cause:Data Entry error and user requested to update the overdue reasons as listed
Fix provided: Data fix to update the over due reasons as below
Contact with Alleged Victim Completed-
    Alleged victim Unavailable
    Attempted Face to Face
    3-4 Attempts
Is Code fix Required?: NO
Code fix ticket#: N/A 
Reason why no related code fix: User error
*/


update cpsresponsetimeractions
set cpsresponsetimerreason1='VAVU', 
	cpsresponsetimerreason2='VAFF',
	cpsresponsetimerreason3='V34F'
where cpsresponsetimeractionsid='c5c73ee9-45c7-4933-bcef-5cafd7e84194' and activeflag=1;