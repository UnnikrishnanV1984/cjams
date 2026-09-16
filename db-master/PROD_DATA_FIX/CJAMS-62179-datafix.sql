
/*
Issue Description: CJAMS-62179
SSA instructed us to enter note in comment box. However, we are not able to enter the comment and we are not able to submit.
Root cause: 1) the LRR Alleged Victim
Alleged victim unavailable
Attempted f2f
3-4 attempts
2) add the caseworker comment as " that TC on 9/4 to both parents and HV attempt on 9/4 = 3 attempts"
Fix provided: Data fix has been done to 
1) the LRR Alleged Victim
Alleged victim unavailable
Attempted f2f
3-4 attempts
2) add the caseworker comment as " that TC on 9/4 to both parents and HV attempt on 9/4 = 3 attempts"
Data/Code fix ticket#: CJAMS-62179
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This is a one-off user entry error; application logic and dropdown options are functioning correctly. A data fix was sufficient to correct the reason values.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

UPDATE cpsresponsetimeractions
SET caseworkercomments = caseworkercomments || 'That TC on 9/4 to both parents and HV attempt on 9/4 = 3 attempts',
    cpsresponsetimerreason1 = 'VAVU',
    cpsresponsetimerreason2 = 'VAFF',
    cpsresponsetimerreason3 = 'V34F',
    updatedon = now(),
    updatedby = 'CJAMS-62179'
WHERE cpsresponsetimeractionsid = '7aceba4e-ad68-45b1-b2cf-383d5a8549a9'
  AND intakeserviceid = 'b69db307-a5cf-4bc8-9d47-2b1956adadfc'
  AND activeflag = 1;