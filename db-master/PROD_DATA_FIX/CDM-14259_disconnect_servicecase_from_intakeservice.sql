--CDM-14259
-- Wrongly connected to a service case. As requested by user, removing the mapping
UPDATE intakeservicerequest 
SET servicecaseid = null,
	updatedon = now(),
	updatedby = 'CDM-14259'
WHERE activeflag = 1 AND servicerequestnumber = '211020114081'; 