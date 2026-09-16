UPDATE intakeservreqchildremoval 
SET updatedby = 'CDM-14802', 
	updatedon = now(), 
	activeflag = 0
WHERE intakeservreqchildremovalid = '144ba100-87b3-44c6-a7ea-fce468a86f75' AND activeflag=1;

UPDATE personprogramarea 
SET updatedby = 'CDM-14802', 
	updatedon = now(), 
	activeflag = 0
WHERE personprogramid = '51eb7ff6-06c4-434e-81a6-08c1aa63b7bd' AND activeflag=1;