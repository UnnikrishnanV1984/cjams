/*
   Issue Description: Need data fix to add a new Service log,
   Case# 251030580680, Client ID: 203971922 (Fany Guerra Romero)
   Program: CPS
   1. Provider ID & Name - 5062435 Ad Astra
   2. Service Name - Translation (Paid) 
   3. Frequency - One time occurrence 
   4. Duration - 2 hours per visit 
   5. Estimated and Actual Begin date  - 9/11/2024
   6. Estimated and Actual End date. - 9/11/2024
   7. Service End Reason - Service Completed.
   After the Service log is added, need to be able to enter a Purchase authorization for the mentioned dates.

   Category/ Module  : service log
   Root cause: System error,  unable to enter a Service log due to the CPS program has been already ended and the system is not allowing to select the Estimated Begin date and Estimated End date to proceed further. 
   This needs a code fix where the system should allow to select the dates range within the selected program date period even when the program is ended.
   Pull request# for code fix: 
   Reason why no related code fix: need codefix,  CDM-44555
   Status of the code fix if already submitted and expected prod fix date: 
*/

INSERT INTO cjams.tb_service_log
( client_id, case_id, provider_service_id, agency_service_ldss_id, referred_dt, start_dt, end_dt, description_tx, outcome_tx, no_service_reason_cd, end_service_reason_cd, purchase_type_cd, create_ts, ldss_cd, create_user_id, start_tm, update_ts, end_tm, update_user_id, delete_sw, court_ordered_sw, estimated_start_dt, estimated_end_dt, frequency_cd, duration_cd, agency_program_area_id, data_valid_sw, client_merge_id, client_program_id, intakeservicerequestactorid, serviceplanid, serviceplanactionid, etl_userid, etl_load_date, agency_sub_program_area_id, end_service_subcategory_reason, end_reason_desc_tx)
VALUES( 203971922, 251030580680, 222564, NULL, '2024-09-11', '2024-09-11', '2024-09-11', NULL, NULL, 'abcd', '1824', NULL, now(), '1430', 'CIDM-10876', NULL, now(), NULL, 'CIDM-10876', 'N', 'N', '2024-09-11', '2024-09-11', '6070', '6042', 'CPS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);