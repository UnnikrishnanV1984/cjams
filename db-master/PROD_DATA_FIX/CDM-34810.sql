/*
 * CDM-34810 - Issue
 * Customer Email ID:alexandra.mcclellan@maryland.gov
 * Customer Name:Alexandra McClellan
 * Focus Area:Case Audit Trail
 * Description - Dashboard:When I send a case for closure it sends twice.
 * Removed duplicate case 3271302
 * 
 */

select distinct routingid,* from routing where servicerequestnumber='3271302' and objectid = 'db6a5383-8305-4778-96ad-2f8feb2a5696' and activeflag=1;
UPDATE cjams.routing
SET activeflag=0, updatedby = 'CDM-34810',updatedon = now() 
WHERE routingid='056467df-d415-4d87-9481-0351cf2525af';

select activeflag, * from servicecasedisposition where servicecasedispositionid = 'db6a5383-8305-4778-96ad-2f8feb2a5696';
UPDATE cjams.servicecasedisposition
SET activeflag=0, updatedby = 'CDM-34810',updatedon = now() 
WHERE servicecasedispositionid='db6a5383-8305-4778-96ad-2f8feb2a5696';
