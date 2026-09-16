/*
Issue: CJAMS-64850 Flex Funds
Category/Module: Service log
Root cause: There is overlapping Service log due to which user is unable to end the Service log.
Fix provided:  Data fix has been done to end date the service log with following information
               Need data fix to end the Service log with "07/22/2019".
                1. Actual End date - 07/22/2019.
                2. Service End Reason - Service Completed.
                3. The same needs to be updated on the PDF print. 
Data/Code fix ticket#: CJAMS-64850
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error and requested for a data fix 
*/

update tb_service_log
set end_dt = '07-22-2019',
    update_ts = now(), 
	update_user_id = 'CJAMS-64850',
    end_service_reason_cd= '1824'  
where service_log_id ='928925'
and delete_sw = 'N';