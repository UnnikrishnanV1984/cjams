/*
Issue Description: CJAMS-69795
Category/Module: Overdue Reason
Root cause: Data entry error - user selected the wrong Response Timer overdue (LRR) reason
            and requested it be updated to Case not assigned timely > Supervisor delays for
            both "Contact with Alleged Victim Completed" and
            "Contact with Initial Contact Caregiver Attempted or Completed".
Fix provided: Data fix to update the overdue reason as Case not assigned timely > Supervisor delays
              for the Alleged Victim (reason1/2) and Initial Contact Caregiver (reason7/8) groups.
Is code fix required : N
Reason why no related code fix: User error
Regression impacts: NA
*/


update cpsresponsetimeractions
set cpsresponsetimerreason1='VCNT',
	cpsresponsetimerreason2='VSDT',
	cpsresponsetimerreason7='CCNT',
	cpsresponsetimerreason8='CSDT',
	updatedby='CJAMS-69795',
	updatedon=now()
where cpsresponsetimeractionsid = '71ddb051-01b1-41a9-9154-bd7c62ecd2eb'
      and intakeserviceid ='f13f847f-cb5f-45f2-b9ae-5577a1ea0151'
      and activeflag =1;