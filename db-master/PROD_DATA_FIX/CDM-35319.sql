/*
 * CDM-35319 - Service Logs
 * Customer Email ID:morris.richmond@maryland.gov
 * Customer Name:Morris Richmond
 * Focus Area:Services: Service Log
 * do the data fix for the following Service Log end dates.
 * The End Date should be 08/15/2023 because the end removal date is 08/16/2023
 * Case ID - 3214417
 * CJAMS PID - 3815335
 * 
 */

--select distinct end_dt, * from tb_service_log where service_log_id in (
--2678964, 2096163, 2074496, 2064850, 2051542, 2046726, 2043092, 1982567, 1982506 
--); 

UPDATE cjams.tb_service_log
SET end_dt='2023-08-15', update_user_id='CDM-35319', update_ts=now() 
WHERE service_log_id in (
2678964, 2096163, 2074496, 2064850, 2051542, 2046726, 2043092, 1982567, 1982506 
); 
