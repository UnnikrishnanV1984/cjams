/*
Issue: CJAMS-64127 End dated service log
Category/Module: Service Log
Root cause: As per system design, the service log can not be ended prior to the latest purchase authorization end date and beyond the selected client program date period.

In this case, the client program is ended prior to the latest purchase authorization end-date in the service log. So data fix is needed to ended the respective open service log with 10/21/2024.
            Client ID: 200640530 (Cam’ron Adams)
            Provider ID: 5034072 (Prince George's County DSS)
            Service: Financial Management (Paid)
            Client Program Name: Out of Home (OOH)
            OOH Program End Date: 09/19/2024
            Latest Auth End Date: 10/21/2024
Fix provided:  Data fix has been done to update the endate the overlapping servicelogs with 10/21/2024
                
Data/Code fix ticket#: CJAMS-64127 
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: These are the old logs which we entered with overlapping dates and data fix needed to fix them.
*/


--provider id 5034072 

update tb_service_log
set end_dt ='2024-10-21',
    update_user_id ='CJAMS-64127', 
    update_ts =now(),
    end_service_reason_cd = '1824'
where service_log_id in ('3537471') and delete_sw='N' ;