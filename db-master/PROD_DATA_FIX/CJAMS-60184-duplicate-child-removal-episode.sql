/*
 * CJAMS-60184- duplicate removal
 * Customer Email ID: julie.boyd@montgomerycountymd.gov
 * Client: 200932248 (Rylee Lites), Case# 202106906507.
 * Focus Area:Child Removal
 * remove the duplicate child removal in Review status.
 */
UPDATE intakeservreqchildremoval 
SET activeflag = 0, 
updatedby = 'CJAMS-60184', 
updatedon = now() 
WHERE intakeservreqchildremovalid = '10f5e87c-a1f9-4f57-87ef-5b2e29ed71f0';

update intakeservreqchildremoval_history
set activeflag = 0,
updatedby = 'CJAMS-60184', 
updatedon = now() 
WHERE intakeservreqchildremovalid = '10f5e87c-a1f9-4f57-87ef-5b2e29ed71f0';

update routing 
set activeflag = 0,
updatedby = 'CJAMS-60184', 
updatedon = now() 
WHERE objectid = '10f5e87c-a1f9-4f57-87ef-5b2e29ed71f0';