-- CDM-21413 - Removal

/*
Worker attempted to end date removal but inadvertently started another removal. 
Is it possible for the removal to be removed immediately.

Case ID: 2020034604723
*/

-- To remove the duplicate Removal in teh Draft Status

update intakeservreqchildremoval 
	set activeflag = 0, updatedby = 'CDM-21413', updatedon = now()
where intakeservreqchildremovalid = '6d1b5c78-acdf-45af-ae5e-e7f154297747';

