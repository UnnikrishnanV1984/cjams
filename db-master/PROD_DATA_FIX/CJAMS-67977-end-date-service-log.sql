

/*
   Issue Description: CJAMS-67977-end-date-service-log
   Category/ Module  In this case, the latest approved purchase authorization end date is beyond the client program end date so data fix is needed to end the service log with 06/20/2025.

Client ID: 204139946 (Diana Awkward)
Provider ID: 5015689 (Food Depot)
Service: Food (Paid)
Service Log Begin Date: 05/11/2025
Client Program Name: In-Home Services/Family Preservation
Client Sub Program Name: Interagency Family Preservation Services
Client Program Start & End Date: 05/11/2025 - 05/11/2025
Purchase Auth ID: 3823409
Purchase Auth End Date: 06/20/2025
   Root cause: user wants to end date
   Pull request# for code fix: 
*/

update tb_service_log
set end_dt = '2025-06-20'::date,
    end_service_reason_cd = '1824', -- Service Completed
	update_ts = now(), 
	update_user_id = 'CJAMS-67977'
where client_id=204139946 and delete_sw = 'N' and service_log_id in (3712092);

