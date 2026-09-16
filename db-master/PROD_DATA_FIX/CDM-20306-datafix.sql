--CDM-20543

UPDATE intakeservicerequest
SET responsetimer = '2021-12-21 11:30:00.000',
	updatedby = 'CDM-20306',
	updatedon = now()
WHERE servicerequestnumber = '211020169286';
