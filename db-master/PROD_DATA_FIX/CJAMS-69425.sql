/*
Issue: CJAMS-69425 - Incorrect Timer Stop Selection
User requested to update the overdue reasons as listed below
   on Intake# 261023736683

   Contact with Alleged Victim Completed : Case not assigned timely / Supervisor delays
   Contact with Initial Contact Caregiver Attempted or Completed : Case not assigned timely / Supervisor delays

Category/Module: Response Timer, Overdue Reason
Root cause: Data entry error - the worker selected the incorrect overdue reasons for the alleged victim and the initial contact caregiver.
Fix provided: Data fix has been done to update the LRR alleged victim and initial contact caregiver overdue reasons as requested.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data entry error.
*/

update cjams.cpsresponsetimeractions
set
    cpsresponsetimerreason1 = 'VCNT', -- Case not assigned timely
    cpsresponsetimerreason2 = 'VSDT', -- Supervisor delays
    cpsresponsetimerreason7 = 'CCNT', -- Case not assigned timely
    cpsresponsetimerreason8 = 'CSDT', -- Supervisor delays
    updatedby = 'CJAMS-69425',
    updatedon = now ()
where
    cpsresponsetimeractionsid = 'ec259a5b-6a8b-4479-ae04-fcf1ec41967f'
    and intakeserviceid = '38291e20-8fef-45b2-9df2-e2773b037410'
    and activeflag = 1;
