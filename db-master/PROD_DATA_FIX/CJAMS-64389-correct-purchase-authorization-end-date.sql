/*
Issue: CJAMS-64389 Flex Fund
Category/Module: Purchase Authorization
Root cause: This is not a defect. The worker incorrectly entered the purchase authorization end date with 09/30/2027. The purchase authorization has been approved and interfaced with the D365.
            In this case, the Finance approval is required to modify the purchase authorization end date from 09/30/2027 to 09/30/2025 as this date need to be fixed on the FMIS/D365 application side else well.
            Please proceed with the data fix to update the purchase authorization & Payment end date to 09/30/2025.

            Client ID: 204187168 (Ashton Harrell)
            Provider ID: 6250274 (Bianca Von Hendricks)
            Auth ID: 3906991
            Payment ID: 4870946
Fix provided:  Data fix has been done to update the purchase authorization & Payment end date to 09/30/2025.
            Client ID: 204187168 (Ashton Harrell)
            Provider ID: 6250274 (Bianca Von Hendricks)
            Auth ID: 3906991
            Payment ID: 4870946
Data/Code fix ticket#: CJAMS-64389 
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User data entry error.
*/

update tb_service_purchase_authorization
set end_dt='2025-09-30',
    update_user_id ='CJAMS-64389',
    update_ts =now()
where service_log_id in ('3812952') and authorization_id ='3906991' and delete_sw='N' ;


UPDATE tb_slpa_snapshot
SET end_dt ='2025-09-30',update_user_id ='CJAMS-64389', update_ts =now()
where service_log_id in ('3812952') and authorization_id ='3906991' and delete_sw='N' ;


update  tb_payment_detail
set final_service_end_dt ='2025-09-30',update_user_id ='CJAMS-64389', update_ts =now()
where payment_id = '4870946' and delete_sw ='N' and payment_detail_id ='6157376';

