/*
 * CDM-39314 - Deontay Jones(1721668)
 * Customer Email ID:marjorie.williams@maryland.gov
 * Description - Dashboard:Deontay Jones(1721668): This is a request to remove four of Deontay's redeterminations as follows: 4-2021, 
 * 4-2022, 4-2023 and 3-18-2024. It was determined after the redets were sent for review that his case became Ineligible 
 * in his 4-2020 redet due to him being on Runaway over six consecutive months from 3/14/2020 to 8/27/2021. 
 * 
 */

-- INSERT INTO cjams.tb_eligibility_period
-- (eligibility_period_id, type_cd, start_dt, end_dt, status_cd, eligibility_id, create_ts, create_user_id, update_ts, update_user_id, delete_sw, etl_userid, etl_load_date, sqnm_sw, approvalstatus, approvalid, finalresult, progressnoteid, ivenarrativesection, approvedby, approvedon, supervisorname, supervisorsubmissiondate, supervisorsignature, specialistname, specialistsubmissiondate, specialistsignature)
-- VALUES(1281001, NULL, '2024-03-18 00:00:00.000', NULL, '2912 ', 155581, '2024-05-30 12:16:34.126', 'admin', '2024-05-30 13:07:06.208', 'admin', 'N', NULL, NULL, '18BDAY', 'REJECTED', '9c64a02d-4d08-42bd-87ae-3567105b04df', 'ELIGIBLE_NON_REIMBURSABLE', '4738dea8-8a7e-4953-8a9b-d60c0e00b9aa'::uuid, 'YES', 'Crystal Aye', '2024-05-30 17:15:04.844', NULL, NULL, NULL, NULL, NULL, NULL);
-- INSERT INTO cjams.tb_eligibility_period
-- (eligibility_period_id, type_cd, start_dt, end_dt, status_cd, eligibility_id, create_ts, create_user_id, update_ts, update_user_id, delete_sw, etl_userid, etl_load_date, sqnm_sw, approvalstatus, approvalid, finalresult, progressnoteid, ivenarrativesection, approvedby, approvedon, supervisorname, supervisorsubmissiondate, supervisorsignature, specialistname, specialistsubmissiondate, specialistsignature)
-- VALUES(1280009, NULL, '2021-04-01 00:00:00.000', '2022-03-31 00:00:00.000', '2912 ', 155581, '2024-05-29 16:24:44.567', 'admin', '2024-05-29 16:32:29.118', 'admin', 'N', NULL, NULL, 'R6', 'REJECTED', 'b0d4c23f-52c5-4626-8031-e15724acd219', 'ELIGIBLE_NON_REIMBURSABLE', 'ff957761-bc1e-4957-9b3f-295c970cfbd7'::uuid, 'YES', 'Crystal Aye', '2024-05-30 17:15:22.908', NULL, NULL, NULL, NULL, NULL, NULL);
-- INSERT INTO cjams.tb_eligibility_period
-- (eligibility_period_id, type_cd, start_dt, end_dt, status_cd, eligibility_id, create_ts, create_user_id, update_ts, update_user_id, delete_sw, etl_userid, etl_load_date, sqnm_sw, approvalstatus, approvalid, finalresult, progressnoteid, ivenarrativesection, approvedby, approvedon, supervisorname, supervisorsubmissiondate, supervisorsignature, specialistname, specialistsubmissiondate, specialistsignature)
-- VALUES(1280109, NULL, '2022-04-01 00:00:00.000', '2023-03-31 00:00:00.000', '2912 ', 155581, '2024-05-29 16:41:48.194', 'admin', '2024-05-29 16:55:56.183', 'admin', 'N', NULL, NULL, 'R7', 'REJECTED', 'ceec1c4c-9b71-450a-bb2c-78ea39c735d2', 'ELIGIBLE_NON_REIMBURSABLE', 'b5821532-afc1-4904-96f5-b78d90862463'::uuid, 'YES', 'Crystal Aye', '2024-05-30 17:15:38.185', NULL, NULL, NULL, NULL, NULL, NULL);
-- INSERT INTO cjams.tb_eligibility_period
-- (eligibility_period_id, type_cd, start_dt, end_dt, status_cd, eligibility_id, create_ts, create_user_id, update_ts, update_user_id, delete_sw, etl_userid, etl_load_date, sqnm_sw, approvalstatus, approvalid, finalresult, progressnoteid, ivenarrativesection, approvedby, approvedon, supervisorname, supervisorsubmissiondate, supervisorsignature, specialistname, specialistsubmissiondate, specialistsignature)
-- VALUES(1280208, NULL, '2023-04-01 00:00:00.000', '2024-03-31 00:00:00.000', '2912 ', 155581, '2024-05-29 17:49:26.275', 'admin', '2024-05-29 18:10:50.960', 'admin', 'N', NULL, NULL, 'R8', 'REJECTED', 'ac98276b-3790-4fa5-9b47-b8a73d0c253d', 'ELIGIBLE_NON_REIMBURSABLE', '5dcd5b26-e200-4c22-93cb-196c8eb0a71d'::uuid, 'YES', 'Crystal Aye', '2024-05-30 17:15:50.544', NULL, NULL, NULL, NULL, NULL, NULL);

DELETE FROM cjams.tb_eligibility_period
WHERE approvalid in (
'ac98276b-3790-4fa5-9b47-b8a73d0c253d',
'ceec1c4c-9b71-450a-bb2c-78ea39c735d2',
'b0d4c23f-52c5-4626-8031-e15724acd219',
'9c64a02d-4d08-42bd-87ae-3567105b04df');
