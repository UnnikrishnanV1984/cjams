/*
Issue: CJAMS-64388 Flex Fund
Category/Module: Purchase Authorization
Root cause: This is not a defect. The worker incorrectly entered the purchase authorization end date with 10/31/2027. The purchase authorization has been approved and interfaced with the D365.
            In this case, the Finance approval is required to modify the purchase authorization end date from 10/31/2027 to 10/31/2025 as this date need to be fixed on the FMIS/D365 application side else well.
            Client ID: 201116250 (Brazyl Baker)
            Provider ID: 6023299 (Dana Brown)
            Auth ID: 3926678
            Payment ID: 4878839
            Payment Date: 11/10/2025
Fix provided:  Data fix has been done to update the purchase authorization & Payment end date to 10/31/2025.
               Client ID: 201116250 (Brazyl Baker)
               Provider ID: 6023299 (Dana Brown)
               Auth ID: 3926678
               Payment ID: 4878839 
Data/Code fix ticket#: CJAMS-64388 
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User data entry error.
*/

update tb_service_purchase_authorization
set end_dt='2025-10-31',
    update_user_id ='CJAMS-64388',
    update_ts =now()
where service_log_id in ('2834820') and authorization_id ='3926678' and delete_sw='N' ;


UPDATE tb_slpa_snapshot
SET end_dt ='2025-10-31',update_user_id ='CJAMS-64388', update_ts =now()
where service_log_id in ('2834820') and authorization_id ='3926678' and delete_sw='N' ;


update  tb_payment_detail
set final_service_end_dt ='2025-10-31',update_user_id ='CJAMS-64388', update_ts =now()
where payment_id = '4878839' and delete_sw ='N' and payment_detail_id ='6164897';

