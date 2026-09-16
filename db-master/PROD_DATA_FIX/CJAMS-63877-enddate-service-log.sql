/*
Issue: CJAMS-63877 Case closure
Category/Module: Service Log
Root cause: As per system design, duplicate or multiple service logs can not be created on the same date period for the same client ID, Provider/Vendor ID and Service.
            In this case, there is an overlapping service log has been created so data fix is needed to ended the open service log with 06/03/2016.
Fix provided:  Data fix has been done to update the ended the open service log with 06/03/2016.
                Case ID: 3266320
                Client ID: 3867365 (COLLEEN WILLIAMS)
                Provider ID: 5034072 (Prince George's County DSS)
                Client Program Name: Auxiliary Services
                Estimated Begin Date: 05/20/2016
                Auxiliary Program End Date: 01/14/2022
                Auth ID: 512187
                Auth End Date: 06/03/2016
Data/Code fix ticket#: CJAMS-63877 
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This is as per the system design and data fix needed to resolve it.
*/


update tb_service_log
set end_dt ='2016-06-03',
    update_user_id ='CJAMS-63877', 
    update_ts =now(),
    end_service_reason_cd = '1824'
where service_log_id in ('719463') and delete_sw='N' ;