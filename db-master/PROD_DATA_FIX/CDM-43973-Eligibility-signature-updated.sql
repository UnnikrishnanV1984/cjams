/*
   Issue Description: CDM-43973 Eligibility Worksheet Supervisor signature On Eligibility details shows the send for approval date as 10/11/2024
					  but the Eligibility worksheet(check below) shows : 01-16-2025
   Category/ Module  : Title IV-E
   Root cause: Supervisor Signature is not matching with Eligibility worksheet approval Date. We are unable to reproduce this issue in the local will closely monitor it.
               The DB is also updated with the date 1-16-2025 and 1-19-2025 as dates but we are unable to replicate it.
   Fix Provided: Data fix has been made to update the supervisor and IV-E Specailist Date as 2024-10-11 
   Data/Code fix ticket#: CDM-43973
   Regression Impacts: N/A
   Is Code fix Required?: No
   Code fix ticket#: N/A
   Reason why no related code fix: We are not able replicate the scenario in local and will closely monitor it for furture replication.
   Status of the code fix if already submitted and expected prod fix date:  
*/

update tb_ive_fostercare_audit 
set specialistsubmissiondate = '2024-10-11 18:35:46',
    supervisorsubmissiondate = '2024-10-11 18:45:46',
    updatedby = 'CDM-43973',
    updatedon = now()
where eligibility_period_id = 1372419 