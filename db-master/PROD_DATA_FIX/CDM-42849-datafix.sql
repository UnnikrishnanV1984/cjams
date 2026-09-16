/*
 Issue Description:  CDM-42849
 Category/ Module: Approval Dashboard
 Root cause: User request to change the dates 08/01/2024 - 08/31/2024 of Purchase Authorization (3680092) 
 Pull request# for code fix: NA
 Reason why no related code fix: For deleting the users from CJAMS data fix is needed
 Status of the code fix if already submitted and expected prod fix date: NO
 Backup before update/ delete: NA
 */

 update tb_service_purchase_authorization
set start_dt = '2024-08-01', end_dt = '2024-08-31', update_user_id = 'CDM-42004', update_ts = now()
where authorization_id = 3680092;