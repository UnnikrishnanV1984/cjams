/*
   Issue Description: CDM-38497 Case Closing
   Category/ Module  :Services
   Root cause : 3301478:We are trying to oclose this case and are unable due to the open Flex Fund/Service Log. We have tried different dates and keep getting the messages of can't close it before the date of the Purchase Authuration or can't end date past the estimated end date. Please end date this Service Log so we can close the case.
   Resolution: Updated end date to the specified service log end date
   Pull request# for code fix: 
   Reason why no related code fix: 
   requested a data fix to resolve:
*/

update tb_service_log set end_dt ='2023-10-23',update_ts =now(),update_user_id ='CDM-38497' where service_log_id='3050480';
