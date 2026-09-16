DELETE FROM  tb_client_income_source 
WHERE INCOME_SOURCE_ID in (1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28);
INSERT INTO cjams.tb_client_income_source
(income_source_id, income_source_tx, earned_sw, exempt_sw, create_ts, create_user_id, update_ts, update_user_id, delete_sw)
VALUES(1, 'Child Support', 'U', 'N', '2002-02-18 18:20:36.000', 'cadmin', '2002-02-18 18:20:36.000', 'cadmin', 'N');
INSERT INTO cjams.tb_client_income_source
(income_source_id, income_source_tx, earned_sw, exempt_sw, create_ts, create_user_id, update_ts, update_user_id, delete_sw)
VALUES(2, 'Deemed Income', 'U', 'N', '2002-02-18 18:20:56.000', 'cadmin', '2002-02-18 18:20:56.000', 'cadmin', 'N');
INSERT INTO cjams.tb_client_income_source
(income_source_id, income_source_tx, earned_sw, exempt_sw, create_ts, create_user_id, update_ts, update_user_id, delete_sw)
VALUES(3, 'Grants/Loans Non-Federal', 'U', 'N', '2002-02-18 18:21:37.000', 'cadmin', '2002-02-18 18:21:37.000', 'cadmin', 'N');
INSERT INTO cjams.tb_client_income_source
(income_source_id, income_source_tx, earned_sw, exempt_sw, create_ts, create_user_id, update_ts, update_user_id, delete_sw)
VALUES(4, 'None - Unearned', 'U', 'N', '2002-02-18 00:00:00.000', 'cadmin', '2002-02-18 18:21:37.000', 'cadmin', 'N');
INSERT INTO cjams.tb_client_income_source
(income_source_id, income_source_tx, earned_sw, exempt_sw, create_ts, create_user_id, update_ts, update_user_id, delete_sw)
VALUES(7, 'Sick Leave Benefits', 'U', 'N', '2002-02-18 00:00:00.000', 'cadmin', '2002-02-18 18:21:37.000', 'cadmin', 'N');
INSERT INTO cjams.tb_client_income_source
(income_source_id, income_source_tx, earned_sw, exempt_sw, create_ts, create_user_id, update_ts, update_user_id, delete_sw)
VALUES(8, 'Social Security Retirement', 'U', 'N', '2002-02-18 00:00:00.000', 'cadmin', '2006-10-25 19:21:16.000', 'DBCR2762', 'N');
INSERT INTO cjams.tb_client_income_source
(income_source_id, income_source_tx, earned_sw, exempt_sw, create_ts, create_user_id, update_ts, update_user_id, delete_sw)
VALUES(9, 'Unemployment Compensation', 'U', 'N', '2002-02-18 00:00:00.000', 'cadmin', '2002-02-18 00:00:00.000', 'cadmin', 'N');
INSERT INTO cjams.tb_client_income_source
(income_source_id, income_source_tx, earned_sw, exempt_sw, create_ts, create_user_id, update_ts, update_user_id, delete_sw)
VALUES(10, 'Veteran Benefits', 'U', 'N', '2002-02-18 00:00:00.000', 'cadmin', '2002-02-18 00:00:00.000', 'cadmin', 'N');
INSERT INTO cjams.tb_client_income_source
(income_source_id, income_source_tx, earned_sw, exempt_sw, create_ts, create_user_id, update_ts, update_user_id, delete_sw)
VALUES(13, 'None - Earned', 'E', 'N', '2002-02-18 00:00:00.000', 'cadmin', '2002-02-18 00:00:00.000', 'cadmin', 'N');
INSERT INTO cjams.tb_client_income_source
(income_source_id, income_source_tx, earned_sw, exempt_sw, create_ts, create_user_id, update_ts, update_user_id, delete_sw)
VALUES(15, 'Self Employment Earning', 'E', 'N', '2002-02-18 00:00:00.000', 'cadmin', '2002-02-18 00:00:00.000', 'cadmin', 'N');
INSERT INTO cjams.tb_client_income_source
(income_source_id, income_source_tx, earned_sw, exempt_sw, create_ts, create_user_id, update_ts, update_user_id, delete_sw)
VALUES(17, 'Wages or Salary', 'E', 'N', '2002-02-18 00:00:00.000', 'cadmin', '2002-02-18 00:00:00.000', 'cadmin', 'N');
INSERT INTO cjams.tb_client_income_source
(income_source_id, income_source_tx, earned_sw, exempt_sw, create_ts, create_user_id, update_ts, update_user_id, delete_sw)
VALUES(19, 'Federal Grants/Loans', 'U', 'Y', '2002-02-18 00:00:00.000', 'cadmin', '2002-02-18 00:00:00.000', 'cadmin', 'N');
INSERT INTO cjams.tb_client_income_source
(income_source_id, income_source_tx, earned_sw, exempt_sw, create_ts, create_user_id, update_ts, update_user_id, delete_sw)
VALUES(20, 'IV-E Payments', 'U', 'Y', '2002-02-18 00:00:00.000', 'cadmin', '2002-02-18 00:00:00.000', 'cadmin', 'N');
INSERT INTO cjams.tb_client_income_source
(income_source_id, income_source_tx, earned_sw, exempt_sw, create_ts, create_user_id, update_ts, update_user_id, delete_sw)
VALUES(21, 'Student Income', 'U', 'Y', '2002-02-18 00:00:00.000', 'cadmin', '2002-02-18 00:00:00.000', 'cadmin', 'N');
INSERT INTO cjams.tb_client_income_source
(income_source_id, income_source_tx, earned_sw, exempt_sw, create_ts, create_user_id, update_ts, update_user_id, delete_sw)
VALUES(22, 'Other - Unearned', 'U', 'N', '2002-02-20 00:00:00.000', 'cadmin', '2006-11-15 18:45:42.000', 'DBCR2927', 'N');
INSERT INTO cjams.tb_client_income_source
(income_source_id, income_source_tx, earned_sw, exempt_sw, create_ts, create_user_id, update_ts, update_user_id, delete_sw)
VALUES(23, 'Other - Earned', 'E', 'N', '2002-02-20 00:00:00.000', 'cadmin', '2006-11-15 18:45:42.000', 'DBCR2927', 'N');
INSERT INTO cjams.tb_client_income_source
(income_source_id, income_source_tx, earned_sw, exempt_sw, create_ts, create_user_id, update_ts, update_user_id, delete_sw)
VALUES(25, 'TANF', 'U', 'Y', '2002-04-22 00:00:00.000', 'cadmin', '2002-04-22 00:00:00.000', 'cadmin', 'N');
INSERT INTO cjams.tb_client_income_source
(income_source_id, income_source_tx, earned_sw, exempt_sw, create_ts, create_user_id, update_ts, update_user_id, delete_sw)
VALUES(26, 'SSI/Supplemental Security Income', 'U', 'N', '2006-05-08 00:00:00.000', 'cadmin', '2006-05-08 00:00:00.000', 'cadmin', 'N');
INSERT INTO cjams.tb_client_income_source
(income_source_id, income_source_tx, earned_sw, exempt_sw, create_ts, create_user_id, update_ts, update_user_id, delete_sw)
VALUES(27, 'Social Security Survivors (Benefits)', 'U', 'N', '2006-10-25 19:21:16.000', 'cadmin', '2006-10-25 19:21:16.000', 'cadmin', 'N');
INSERT INTO cjams.tb_client_income_source
(income_source_id, income_source_tx, earned_sw, exempt_sw, create_ts, create_user_id, update_ts, update_user_id, delete_sw)
VALUES(28, 'Social Security Disability Insurance', 'U', 'N', '2006-10-25 19:21:16.000', 'cadmin', '2006-10-25 19:21:16.000', 'cadmin', 'N');