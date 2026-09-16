/*
Issue Description:CJAMS-62173 251023118637:The LRR drop down menu
Category/Module: Overdue Reason
Root cause: User requested to update the below accordingly, Case accepted over the weekend, 9/6/25 , through the extended hours shift. 24 hour mandate not met during that time. Alleged Victim: to reflect the following in the drop down
1. Case not assigned timely
2. Supervisor delay
Initial contact caregiver: to reflect the following in the drop down
1. Case not assigned timely
2. Supervisor delay
Fix provided: Data fix has been promoted to to update the below accordingly, Case accepted over the weekend, 9/6/25 , through the extended hours shift. 24 hour mandate not met during that time. Alleged Victim: to reflect the following in the drop down
1. Case not assigned timely
2. Supervisor delay
Initial contact caregiver: to reflect the following in the drop down
1. Case not assigned timely
2. Supervisor delay
Regression Impacts: N/A
Is Code fix Required?: NO
Code fix ticket#: N/A 
Reason why no related code fix: Data fix needed to correct the user entry error
*/

update cpsresponsetimeractions
set supervisorcomments = 'Case accepted over the weekend, 9/6/25 , through the extended hours shift.
                          24 hour mandate not met during that time.',
    cpsresponsetimerreason1 = 'VCNT',
    cpsresponsetimerreason2 = 'VSDT',
    cpsresponsetimerreason7 = 'CCNT',
    cpsresponsetimerreason8 = 'CSDT',
    updatedon = now(),
    updatedby = 'CJAMS-59773'
where cpsresponsetimeractionsid = '8998be45-408d-477c-acbc-12ea3e828284'
and intakeserviceid = 'e5f9aead-16b2-43bc-b2e7-a76015ea8b0d'
and activeflag = 1;