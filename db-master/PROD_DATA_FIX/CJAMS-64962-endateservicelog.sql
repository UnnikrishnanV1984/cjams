/*
Issue: CJAMS-64962 Flex fund will not close
Category/Module: Service Log
Root cause:The user is unable to end the Service log due to an overlapping Service log and the OOH program assignment is ended prior to the latest purchase authorization end date.
           Need data fix to end the Service log with "07/29/2011" with Service end reason as "Service Completed" and the same need to be updated on the PDF print as well. 
Fix provided:  Data fix has been done to end the Service log with "07/29/2011" with Service end reason as "Service Completed" .
Data/Code fix ticket#: CJAMS-64962
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This is happening due to dates overlapping issue and data fix should resolve it.
*/

update tb_service_log
set end_dt = '2011-07-29',
    update_ts = now(), 
	update_user_id = 'CJAMS-64962',
    end_service_reason_cd= '1824'  
where service_log_id ='347645'
and delete_sw = 'N';