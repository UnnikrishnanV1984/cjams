/*
Issue: CJAMS-64060 Service Log End Dates
Category/Module: Service Log
Root cause: As per system design, duplicate or multiple service logs can not be created on the same date period for the same client ID, Provider/Vendor ID and Service.
            In this case, there is an overlapping service log has been created so data fix is needed to ended the open service log using data fix.
            These are the old logs which we entered with overlapping dates and data fix needed to fix them.
Fix provided:  Data fix has been done to update the endate the overlapping servicelogs with
                Client ID: Client ID: 1990561 (Demetresse M Harris)
                1. Provider ID: 6007185 (Cognitive Cash LLC), Service: Rent Payments/Deposit (Paid). End the Service log with "11/30/2022", Service End Reason with "Service Completed".
                2. Provider ID: 5083795 (Residence Inn Marriott), Service: Rent Payments/Deposit (Paid). End the Service log with "01/27/2022", Service End Reason with "Service Completed".
Data/Code fix ticket#: CJAMS-64060 
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: These are the old logs which we entered with overlapping dates and data fix needed to fix them.
*/


--provider id 5083795 

update tb_service_log
set end_dt ='2022-01-27',
    update_user_id ='CJAMS-64060', 
    update_ts =now(),
    end_service_reason_cd = '1824'
where service_log_id in ('2027121') and delete_sw='N' ;

--provider id 6007185 
update tb_service_log
set end_dt ='2022-11-30',
    update_user_id ='CJAMS-64060', 
    update_ts =now(),
    end_service_reason_cd = '1824'
where service_log_id in ('2057947') and delete_sw='N' ;