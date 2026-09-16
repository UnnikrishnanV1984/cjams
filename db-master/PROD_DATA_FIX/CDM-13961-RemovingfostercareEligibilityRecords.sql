-- CDM-13961 - Removing Eligibility period records
  /*
  Issue Description: 
   Category/ Module  :  IVE Fostercare
   Root cause: User Error
   Pull request# for code fix:  N/A
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 

   */


/*
INSERT INTO cjams.tb_eligibility_period
(eligibility_period_id, type_cd, start_dt, end_dt, status_cd, eligibility_id, create_ts, create_user_id, update_ts, update_user_id, delete_sw, etl_userid, etl_load_date, sqnm_sw, approvalstatus, approvalid, finalresult, progressnoteid, ivenarrativesection, approvedby, approvedon, supervisorname, supervisorsubmissiondate, supervisorsignature, specialistname, specialistsubmissiondate, specialistsignature)
VALUES(903126, NULL, '2019-06-01 00:00:00.000', '2020-05-31 00:00:00.000', '2912 ', 146389, '2020-09-23 11:42:01.230', 'admin', '2020-09-23 11:50:46.309', 'admin', 'N', NULL, NULL, 'R6', 'APPROVED', '5b18105d-9b8f-4ce8-8d73-5619c128ad1c', 'ELIGIBLE_NON_REIMBURSABLE', '4c6ef734-314e-4a50-b862-cefe374685ec'::uuid, 'YES', 'Crystal Aye', '2020-11-06 11:10:29.281', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.tb_eligibility_period
(eligibility_period_id, type_cd, start_dt, end_dt, status_cd, eligibility_id, create_ts, create_user_id, update_ts, update_user_id, delete_sw, etl_userid, etl_load_date, sqnm_sw, approvalstatus, approvalid, finalresult, progressnoteid, ivenarrativesection, approvedby, approvedon, supervisorname, supervisorsubmissiondate, supervisorsignature, specialistname, specialistsubmissiondate, specialistsignature)
VALUES(903129, NULL, '2019-11-10 00:00:00.000', NULL, '2913 ', 146389, '2020-09-23 11:44:15.423', 'admin', '2020-09-23 11:44:15.423', 'admin', 'N', NULL, NULL, '18BDAY', NULL, NULL, 'ELIGIBLE_REIMBURSABLE', NULL, 'YES', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.tb_eligibility_period
(eligibility_period_id, type_cd, start_dt, end_dt, status_cd, eligibility_id, create_ts, create_user_id, update_ts, update_user_id, delete_sw, etl_userid, etl_load_date, sqnm_sw, approvalstatus, approvalid, finalresult, progressnoteid, ivenarrativesection, approvedby, approvedon, supervisorname, supervisorsubmissiondate, supervisorsignature, specialistname, specialistsubmissiondate, specialistsignature)
VALUES(910921, NULL, '2017-06-01 00:00:00.000', '2018-05-31 00:00:00.000', '2912 ', 146389, '2021-06-04 14:27:45.937', 'admin', '2021-06-04 14:27:45.937', 'admin', 'N', NULL, NULL, 'R4', NULL, NULL, 'ELIGIBLE_NON_REIMBURSABLE', '7a62c06b-25f5-4cc8-91f4-d852023ab6b7'::uuid, 'YES', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

*/


delete from tb_eligibility_period tep where eligibility_period_id in ('910921',
'903126',
'903129');
