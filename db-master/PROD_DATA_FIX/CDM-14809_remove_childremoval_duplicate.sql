UPDATE intakeservreqchildremoval 
SET updatedby = 'CDM-14809', 
	updatedon = now(), 
	activeflag = 0
WHERE intakeservreqchildremovalid = 'b297b694-0f59-4298-b2e9-208ab958e23f' AND activeflag=1;
