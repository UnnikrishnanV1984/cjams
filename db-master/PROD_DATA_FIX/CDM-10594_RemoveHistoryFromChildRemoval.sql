-- CDM-10594 - Remove record from child removal history

update intakeservreqchildremoval set activeflag =0, updatedby = 'CDM-10594', updatedon = now() where intakeservreqchildremovalid ='d30f4f63-4801-4d82-9170-0b0df08ba5a6' and activeflag =1;
