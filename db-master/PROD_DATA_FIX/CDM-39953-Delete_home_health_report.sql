/*
 * CDM-39953 - Delete home health report.
 * Customer Email ID:missy.langham@maryland.gov
 * Description - Requested to delete health report from pending approval dashboard.
 */

update routing
set activeflag=0,updatedby='CDM-39953', updatedon=now()
where routingid='fabecf6c-3cd3-485d-989c-2d43547b7954' and activeflag=1;