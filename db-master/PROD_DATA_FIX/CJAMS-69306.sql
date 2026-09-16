/*
Issue Description: CJAMS-69306 - correction to Over Due Reason
Category/Module: Overdue Reason
Case ID: 261023748259
Root cause: Worker picked the wrong reasons in the Legislative Reporting window. The window was already
   approved by the supervisor, so the worker can no longer edit it from the screen.
Fix provided: Data fix to update the over due reason for Contact with Alleged Victim Completed as
   Child out of the jurisdiction > ROA pending - In-state but other LDSS was unable to see alleged victim
   within mandate > Montgomery. The Alleged Victim contact box is also unchecked so the reasons show on
   the screen.
Regression Impacts: N/A
Is Code fix Required?: NO
Code fix ticket#: N/A
Reason why no related code fix: User error
*/


update cpsresponsetimeractions
set cpsresponsetimerreason1 = 'VCOJ',
	cpsresponsetimerreason2 = 'VRIJ',
	cpsresponsetimerreason3 = 'VMOJ',
	updatedby = 'CJAMS-69306',
	updatedon = now()
where cpsresponsetimeractionsid = '2adb85e7-52bf-4385-8de6-097516dbd6cb' and activeflag = 1;