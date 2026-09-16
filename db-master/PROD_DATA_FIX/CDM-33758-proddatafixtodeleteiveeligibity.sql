/*
   Issue Description: CDM-33758
   Category/ Module  : Prod data fix to Remove IVE eligibility
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/



/*
INSERT INTO cjams.tb_eligibility_period
(eligibility_period_id, type_cd, start_dt, end_dt, status_cd, eligibility_id, create_ts, create_user_id, update_ts, update_user_id, delete_sw, etl_userid, etl_load_date, sqnm_sw, approvalstatus, approvalid, finalresult, progressnoteid, ivenarrativesection, approvedby, approvedon, supervisorname, supervisorsubmissiondate, supervisorsignature, specialistname, specialistsubmissiondate, specialistsignature)
VALUES(972133, NULL, '2022-02-01 00:00:00.000', '2022-05-05 00:00:00.000', '2914 ', 163020, '2023-02-27 13:38:20.635', 'admin', '2023-02-27 13:41:53.816', 'admin', 'Y', NULL, NULL, 'R5', 'PENDING', 'd37c8903-ec36-4fa7-8178-3dec4a5712ff', 'INELIGIBLE', '51bd249e-0590-428a-8b18-533295e1c932'::uuid, 'YES', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.tb_eligibility_period
(eligibility_period_id, type_cd, start_dt, end_dt, status_cd, eligibility_id, create_ts, create_user_id, update_ts, update_user_id, delete_sw, etl_userid, etl_load_date, sqnm_sw, approvalstatus, approvalid, finalresult, progressnoteid, ivenarrativesection, approvedby, approvedon, supervisorname, supervisorsubmissiondate, supervisorsignature, specialistname, specialistsubmissiondate, specialistsignature)
VALUES(982131, NULL, '2022-02-01 00:00:00.000', '2022-05-05 00:00:00.000', '2914 ', 163020, '2023-03-13 21:53:54.433', 'admin', '2023-03-13 21:55:17.712', 'admin', 'N', NULL, NULL, 'R5', 'PENDING', '6b1c172e-a3a9-4880-b6d4-1e906f42fac6', 'INELIGIBLE', '8a7dbd4c-1ae1-4500-bdc4-ec7c68763c19'::uuid, 'YES', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.tb_eligibility_period
(eligibility_period_id, type_cd, start_dt, end_dt, status_cd, eligibility_id, create_ts, create_user_id, update_ts, update_user_id, delete_sw, etl_userid, etl_load_date, sqnm_sw, approvalstatus, approvalid, finalresult, progressnoteid, ivenarrativesection, approvedby, approvedon, supervisorname, supervisorsubmissiondate, supervisorsignature, specialistname, specialistsubmissiondate, specialistsignature)
VALUES(918296, NULL, '2021-02-01 00:00:00.000', '2022-01-31 00:00:00.000', '3597', 163020, '2022-05-11 22:07:06.317', 'admin', '2022-05-11 22:07:06.317', 'admin', 'Y', NULL, NULL, 'R4', NULL, NULL, '201_MISSING_INFO', NULL, 'YES', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.tb_eligibility_period
(eligibility_period_id, type_cd, start_dt, end_dt, status_cd, eligibility_id, create_ts, create_user_id, update_ts, update_user_id, delete_sw, etl_userid, etl_load_date, sqnm_sw, approvalstatus, approvalid, finalresult, progressnoteid, ivenarrativesection, approvedby, approvedon, supervisorname, supervisorsubmissiondate, supervisorsignature, specialistname, specialistsubmissiondate, specialistsignature)
VALUES(918297, NULL, '2021-02-01 00:00:00.000', '2022-01-31 00:00:00.000', '2912 ', 163020, '2022-05-11 22:09:15.453', 'admin', '2022-05-11 22:09:15.453', 'admin', 'Y', NULL, NULL, 'R4', NULL, NULL, 'ELIGIBLE_NON_REIMBURSABLE', '9ef5391e-8249-4397-8852-8067dce90abb'::uuid, 'YES', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.tb_eligibility_period
(eligibility_period_id, type_cd, start_dt, end_dt, status_cd, eligibility_id, create_ts, create_user_id, update_ts, update_user_id, delete_sw, etl_userid, etl_load_date, sqnm_sw, approvalstatus, approvalid, finalresult, progressnoteid, ivenarrativesection, approvedby, approvedon, supervisorname, supervisorsubmissiondate, supervisorsignature, specialistname, specialistsubmissiondate, specialistsignature)
VALUES(972098, NULL, '2021-02-01 00:00:00.000', '2022-01-31 00:00:00.000', '2912 ', 163020, '2023-02-27 13:16:41.754', 'admin', '2023-02-27 13:18:35.119', 'admin', 'N', NULL, NULL, 'R4', 'PENDING', '52de8068-f3d5-4e4b-ade4-4ac79de76d39', 'ELIGIBLE_NON_REIMBURSABLE', '0ce44385-5070-4964-bb0f-58679b930541'::uuid, 'YES', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.tb_eligibility_period
(eligibility_period_id, type_cd, start_dt, end_dt, status_cd, eligibility_id, create_ts, create_user_id, update_ts, update_user_id, delete_sw, etl_userid, etl_load_date, sqnm_sw, approvalstatus, approvalid, finalresult, progressnoteid, ivenarrativesection, approvedby, approvedon, supervisorname, supervisorsubmissiondate, supervisorsignature, specialistname, specialistsubmissiondate, specialistsignature)
VALUES(918295, NULL, '2020-02-01 00:00:00.000', '2021-01-31 00:00:00.000', '2913 ', 163020, '2022-05-11 21:59:25.316', 'admin', '2022-05-11 22:01:28.632', 'admin', 'N', NULL, NULL, 'R3', 'PENDING', 'be296bd9-727c-4fcb-a8dc-7672637202a5', 'ELIGIBLE_REIMBURSABLE', '7a3d45be-2934-420c-aa78-354e6e019daa'::uuid, 'YES', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.tb_eligibility_period
(eligibility_period_id, type_cd, start_dt, end_dt, status_cd, eligibility_id, create_ts, create_user_id, update_ts, update_user_id, delete_sw, etl_userid, etl_load_date, sqnm_sw, approvalstatus, approvalid, finalresult, progressnoteid, ivenarrativesection, approvedby, approvedon, supervisorname, supervisorsubmissiondate, supervisorsignature, specialistname, specialistsubmissiondate, specialistsignature)
VALUES(918293, NULL, '2019-02-01 00:00:00.000', '2020-01-31 00:00:00.000', '3599', 163020, '2022-05-11 21:53:51.294', 'admin', '2022-05-11 21:53:51.294', 'admin', 'Y', NULL, NULL, 'R2', NULL, NULL, 'INVALID_CRITERIA', NULL, 'YES', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
*/

DELETE FROM cjams.tb_eligibility_period
WHERE eligibility_period_id=972133;
DELETE FROM cjams.tb_eligibility_period
WHERE eligibility_period_id=982131;
DELETE FROM cjams.tb_eligibility_period
WHERE eligibility_period_id=918296;
DELETE FROM cjams.tb_eligibility_period
WHERE eligibility_period_id=918297;
DELETE FROM cjams.tb_eligibility_period
WHERE eligibility_period_id=972098;
DELETE FROM cjams.tb_eligibility_period
WHERE eligibility_period_id=918295;
DELETE FROM cjams.tb_eligibility_period
WHERE eligibility_period_id=918293;



--INSERT INTO cjams.tb_eligibility_period
--(eligibility_period_id, type_cd, start_dt, end_dt, status_cd, eligibility_id, create_ts, create_user_id, update_ts, update_user_id, delete_sw, etl_userid, etl_load_date, sqnm_sw, approvalstatus, approvalid, finalresult, progressnoteid, ivenarrativesection, approvedby, approvedon, supervisorname, supervisorsubmissiondate, supervisorsignature, specialistname, specialistsubmissiondate, specialistsignature)
--VALUES(918294, NULL, '2019-02-01 00:00:00.000', '2020-01-31 00:00:00.000', '2912 ', 163020, '2022-05-11 21:55:13.701', 'admin', '2023-08-30 07:33:51.137', 'CDM-33758', 'N', NULL, NULL, 'R2', NULL, NULL, 'ELIGIBLE_REIMBURSABLE', '35a5e3b6-4c90-400d-b909-7217c2da592f', 'YES', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


DELETE FROM cjams.tb_eligibility_period
WHERE eligibility_period_id=918294;
