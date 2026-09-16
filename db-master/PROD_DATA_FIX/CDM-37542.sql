/*
 * CDM-37542 - Wrong Dates Entered
 * Customer Email ID:michelle.lockard2@maryland.gov
 * Focus Area:Services: Service Log
 * Description - 3063130:Hello The end date on this should have been 12/22/23 not 1/22/24. 
 * This will need to be corrected and has already been approved.
 * Case # 3063130
 * Client ID# 200938034
 * Vendor ID# 5094146
 * Purchase Auth# 2969535
 * 
 */

select *
	from tb_service_purchase_authorization 
where authorization_id in (2969535)
	and delete_sw = 'N'
    and end_dt = '2024-01-22';
   
UPDATE cjams.tb_service_purchase_authorization
SET end_dt='2023-12-22', update_ts = now(), 
	update_user_id = 'CDM-37542' 
WHERE authorization_id=2969535;
