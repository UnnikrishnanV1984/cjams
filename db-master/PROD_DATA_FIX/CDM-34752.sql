/*
 * CDM-34752 - CPS
 * Customer Email ID:dawn.blades@maryland.gov
 * Customer Name:Dawn Blades
 * Focus Area:Services: Other
 * Description - Dashboard:Worker sent service case for closure and it populated
 * remove the case closure review (case # 3232078) from the supervisor dashboard.
 * 
*/


select distinct routingid,* from routing where servicerequestnumber='3232078' and objectid = 'fd331da5-7763-41e8-b030-ef9a68ccf891' and activeflag=1;
update routing 
set  updatedby = 'CDM-34752',updatedon = now(), activeflag = 0
where  routingid in (
	'2c49d77f-79e8-4f4b-9986-9c796888977a'); 
	