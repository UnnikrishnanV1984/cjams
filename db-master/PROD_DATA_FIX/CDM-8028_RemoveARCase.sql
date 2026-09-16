-- CDM-8028 - Removal of the AR case

update intakeservicerequest set activeflag=0, updatedby = 'CDM-8028', updatedon = now() where intakeserviceid = '18fd722f-1660-4840-a83e-a05a715d7669' and activeflag = 1;
