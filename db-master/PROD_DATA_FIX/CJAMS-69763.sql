/*
Issue Description: CJAMS-69763
Category/Module: Response Timer / Overdue Reason (Legislative Required Reporting)
Root cause: Data entry error - the wrong Response Timer overdue reason was selected for the case.
            Both the Alleged Victim and the Initial Contact Caregiver groups were recorded as
            "Data entry error but face to face met mandate" (VDER / CDER) instead of
            "Case not assigned timely > Supervisor delays".
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
	updatedby='CJAMS-69763',
	updatedon=now()
where cpsresponsetimeractionsid='81fb7a76-1a64-42f5-94f0-5e58e0d29d5f' and activeflag=1;
