UPDATE intakeservreqchildremoval 
SET updatedby = 'CDM-15512', 
	updatedon = now(), 
	activeflag = 0
WHERE intakeservreqchildremovalid = 'ff8e4c91-2356-4d27-97c0-a496ea3eaccc' AND activeflag=1;
