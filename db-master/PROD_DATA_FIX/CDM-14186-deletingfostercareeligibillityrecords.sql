  -- CDM-14186 - Fostercare eligibility periods
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
VALUES(903441, NULL, '2019-06-01 00:00:00.000', '2020-05-31 00:00:00.000', '2912 ', 151465, '2020-10-09 16:01:47.190', 'admin', '2020-10-09 16:06:00.360', 'admin', 'N', NULL, NULL, 'R5', 'APPROVED', '48584c9e-3216-4119-a748-a5448a08d60c', 'ELIGIBLE_REIMBURSABLE', 'ccbbcb14-d5e0-491c-ba2c-325b2c5e4a70'::uuid, 'YES', 'Crystal Aye', '2020-11-23 15:10:25.928', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.tb_eligibility_period
(eligibility_period_id, type_cd, start_dt, end_dt, status_cd, eligibility_id, create_ts, create_user_id, update_ts, update_user_id, delete_sw, etl_userid, etl_load_date, sqnm_sw, approvalstatus, approvalid, finalresult, progressnoteid, ivenarrativesection, approvedby, approvedon, supervisorname, supervisorsubmissiondate, supervisorsignature, specialistname, specialistsubmissiondate, specialistsignature)
VALUES(903443, NULL, '2019-11-09 00:00:00.000', NULL, '2912 ', 151465, '2020-10-09 16:08:53.391', 'admin', '2020-10-09 16:10:40.178', 'admin', 'N', NULL, NULL, '18BDAY', 'APPROVED', '34d53935-2cfe-4340-be32-2ea90f7a1188', 'ELIGIBLE_NON_REIMBURSABLE', 'e48cde94-3788-41e3-8c3c-b7d3b12ef066'::uuid, 'YES', 'Crystal Aye', '2020-11-23 15:06:31.619', NULL, NULL, NULL, NULL, NULL, NULL);
*/


delete from tb_eligibility_period tep where eligibility_period_id in (903441,903443);
