/*
  Issue Description: CJAMS-69700 (HB1248) 
  Category/Module: LRR / Overdue Reason
  Root cause: User data entry error - the caseworker made the wrong drop down selections in the
              Legislative Required Reporting window, leaving the "Contact with Alleged Victim Completed"
              reason chain (cpsresponsetimerreason1/2) empty. No application defect.
  Fix provided: Data fix to update the overdue reason on the active "Save" response timer action record as:
                   Alleged victim Unavailable > Family was contacted but unavailable to meet within mandate
  Regression Impacts: N/A 
  Is Code fix Required?: No
  Code fix ticket#: N/A
  Reason why no related code fix: User input error - data fix resolves it.
*/

UPDATE cjams.cpsresponsetimeractions
   SET allegedvictimcontact    = 'false',  -- unhides the AV reason chain in the LRR window
       cpsresponsetimerreason1 = 'VAVU',   -- Alleged victim Unavailable
       cpsresponsetimerreason2 = 'VFCM',   -- Family was contacted but unavailable to meet within mandate
       updatedby = 'CJAMS-69700',
       updatedon = now()
 WHERE cpsresponsetimeractionsid = 'cc76bc08-f225-4b66-8407-b35231b8fbb2'
   AND intakeserviceid = 'd7cf8770-ff0e-406b-811c-b41aae51de76'
   AND activeflag = 1;

