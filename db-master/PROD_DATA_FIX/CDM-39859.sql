/*
 * CDM-39859 - Stuck Service Log
 * Customer Email ID:michelle.forney@montgomerycountymd.gov
 * Description - 3241865:There is a service log for Client Talonda Wagner, that we cannot enter a actual end date before 
 * because of over lapping dates. The service log we are trying to end date is for Montgomery County, Maryland Financial 
 * Management Paid Date 7/1/21. The actual end date should be 7/1/2023.However, the one below this with a Actual State Date 
 * of 7/1/2020 and Actual End Date of 2/24/22, I think is causing the problem of overlapping dates. The actual End date for 
 * this should have been 7/1/2020.Can this please be fixed. 
 * data fix to end-date the highlighted service log with 07/01/2023.
 * Client ID: 1401294 (TALONDA WAGNER)
 * Provider ID: 5032131 (Montgomery County, Maryland)
 * Service: Financial Management (Paid)
 * Actual Begin Date: 07/01/2021
 * 
 */

--select start_dt , end_dt ,* from tb_service_log  where service_log_id  = 2694659;
UPDATE cjams.tb_service_log
SET end_dt='2023-07-01', update_user_id='CDM-39859', update_ts=now() 
WHERE service_log_id=2694659;
