/*
 * CDM-34490 - duplicate removal
 * Customer Email ID:vivian.mayo@maryland.gov
 * Customer Name:Vivian Mayo
 * Focus Area:Child Removal
 * 3280736:Hello!RE: Sarah M Kendall CJAMS PID# : 3171367. A duplicate removal was created in error. 
 * remove the duplicate child removal in Review status.
 * Client Name : Sarah M Kendall
 * CJAMS PID# : 3171367
 */

select activeflag,* from intakeservreqchildremoval where intakeservreqchildremovalid = '69276e2a-d896-41d6-ac81-4d59278107ad';
UPDATE cjams.intakeservreqchildremoval
SET activeflag=0, updatedby='CDM-34490', updatedon=now() 
WHERE intakeservreqchildremovalid='69276e2a-d896-41d6-ac81-4d59278107ad'::uuid; 

select activeflag, * from intakeservreqchildremoval_history where intakeservreqchildremovalid = '69276e2a-d896-41d6-ac81-4d59278107ad';
UPDATE cjams.intakeservreqchildremoval_history
SET activeflag=0, updatedby='CDM-34490', updatedon=now() 
WHERE intakeservreqchildremovalid='69276e2a-d896-41d6-ac81-4d59278107ad'::uuid;

select activeflag,* from routing where objectid = '69276e2a-d896-41d6-ac81-4d59278107ad';
UPDATE cjams.routing
SET activeflag=0, updatedby='CDM-34490', updatedon=now() 
WHERE objectid='69276e2a-d896-41d6-ac81-4d59278107ad'; 