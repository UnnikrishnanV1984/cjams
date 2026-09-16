/* Issue Description: CDM-25705 */

UPDATE 	cjams.routing 
SET 	activeflag = 0,
		updatedon = NOW(),
		updatedby = 'CDM-25705'
WHERE 	objectid = '64f82350-3ca8-44c5-a5b5-e950705f0058';
