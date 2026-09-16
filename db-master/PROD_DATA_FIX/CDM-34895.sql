/*
 * CDM-34895 - CPS
 * Customer Email ID:dawn.blades@maryland.gov
 * Customer Name:Dawn Blades
 * Focus Area:Services: Other
 * Description - Dashboard:Service case was sent for closure and populated twice in my case pending approval tab. 
 * remove the duplicate review request
 * "servicerequestnumber": "3291576"
 * "objectid": "f9054281-6081-45ea-95e5-7592c09a9629"
 * "servicecasedispositionid": "f9054281-6081-45ea-95e5-7592c09a9629"
 */

select distinct routingid,* from routing where servicerequestnumber='3291576' and objectid = 'f9054281-6081-45ea-95e5-7592c09a9629' and activeflag=1;
UPDATE cjams.routing
SET activeflag=0, updatedby = 'CDM-34895',updatedon = now() 
WHERE routingid='fc5e7336-449a-4224-8fd1-1c3454843d5c';

select activeflag, * from servicecasedisposition where servicecasedispositionid = 'f9054281-6081-45ea-95e5-7592c09a9629';
UPDATE cjams.servicecasedisposition
SET activeflag=0, updatedby = 'CDM-34895',updatedon = now() 
WHERE servicecasedispositionid='f9054281-6081-45ea-95e5-7592c09a9629';
