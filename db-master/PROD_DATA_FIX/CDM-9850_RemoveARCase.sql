-- CDM-9850 - Remove AR Case

update intakeservicerequest set activeflag = 0, updatedby = 'CDM-9850', updatedon = now() where activeflag =1 and intakeserviceid = 'c0ab4609-32d8-41f2-bf4e-72fc3aaf083c';