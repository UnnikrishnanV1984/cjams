
/*
Issue Description: CJAMS-62225
SSA instructed us to enter note in comment box. However, we are not able to enter the comment and we are not able to submit.
Root cause: User requested to update LRR reason:
1. Contact with Alleged Victim Completed -> "Case not assigned timely > supervisor delays."
2. Contact with Other Children Attempted or Completed -> "Case not assigned timely > supervisor delays."
3. Contact with Initial Contact Caregiver Attempted or Completed -> "Case not assigned timely > supervisor delays.
update the Case Worker Comment as "the EH team did not send out a worker and the response time elapsed prior to the next regular business day"
Fix provided: Data fix has been done to update LRR reason:
1. Contact with Alleged Victim Completed -> "Case not assigned timely > supervisor delays."
2. Contact with Other Children Attempted or Completed -> "Case not assigned timely > supervisor delays."
3. Contact with Initial Contact Caregiver Attempted or Completed -> "Case not assigned timely > supervisor delays.
update the Case Worker Comment as "the EH team did not send out a worker and the response time elapsed prior to the next regular business day"
Data/Code fix ticket#: CJAMS-62225
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This is a one-off user entry error; application logic and dropdown options are functioning correctly. A data fix was sufficient to correct the reason values.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

UPDATE cpsresponsetimeractions
SET caseworkercomments = 'The EH team did not send out a worker and the response time elapsed prior to the next regular business day',
    cpsresponsetimerreason1 = 'VCNT',
    cpsresponsetimerreason2 = 'VSDT',
    cpsresponsetimerreason4 = 'OCNT',
    cpsresponsetimerreason5 = 'OSDT',
    cpsresponsetimerreason7 = 'CCNT',
    cpsresponsetimerreason8 = 'CSDT',
    updatedon = now(),
    updatedby = 'CJAMS-62225'
WHERE cpsresponsetimeractionsid = '2099accc-58d8-4093-879b-9f50abac0867'
  AND intakeserviceid = 'a813e604-0049-435a-8bf2-372b2371e5a9'
  AND activeflag = 1;