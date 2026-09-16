/*
  Issue Description: CJAMS-69800 (HB1248 JCR Reconciliation)
  Category/Module: LRR / Overdue Reason
  Root cause: User data entry error - the caseworker selected the wrong reason chains in the
              Legislative Required Reporting window
 Fix provided: Data fix to update all three overdue reason chains on the two active "Save" response
                timer action records to:
                Case not assigned timely > Supervisor delays
                and to correct the Case Worker Comment.
  Regression Impacts: N/A 
  Is Code fix Required?: No
  Code fix ticket#: N/A
  Reason why no related code fix: User input error - data fix resolves it.
*/




UPDATE cjams.cpsresponsetimeractions
   SET cpsresponsetimerreason1 = 'VCNT',   
       cpsresponsetimerreason2 = 'VSDT',   
       cpsresponsetimerreason4 = 'OCNT',   
       cpsresponsetimerreason5 = 'OSDT',  
       cpsresponsetimerreason7 = 'CCNT',   
       cpsresponsetimerreason8 = 'CSDT',  
       caseworkercomments = 'Assigned caseworker was unaware of the response timer calculating to the minute for the AR Neglect',
       updatedby = 'CJAMS-69800',
       updatedon = now()
 WHERE cpsresponsetimeractionsid = 'b5a44805-10c2-49e3-a842-d86d927af120'
   AND intakeserviceid = '0c3ce50e-a577-4bba-977b-cef7a7477131'
   AND activeflag = 1;

