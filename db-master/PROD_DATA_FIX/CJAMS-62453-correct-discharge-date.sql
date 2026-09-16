/*
  Issue Description: Data fix has been done to delete the rejected placements and user requested to correct the hospital dicharge date
  Root cause: User requested to correct the hospital discharge time to 4:00PM and we need data fix for this as it is already approved 
  Fix Provided: Data fix has been done correct the hospital discharge date to 4:00PM for 
                Case ID # : 3231838
                Cjams PID # : 3610015
  Regression Impacts: N/A
  Is Code fix needed: No
  Code fix ticket # : N/A
  Reason why no related code fix: The hospitalization information is already approved and data fix is need to update it.
  */


  update personhospitalization
  set hospital_dischargeddate = '2025-09-23 16:00:00',
      updatedon = now(),
      updatedby = 'CJAMS-62453'
  where hospitalizationid = '9e9e18fa-5542-4cfe-ae43-9b50a4b04ff2';