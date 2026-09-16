-- CDM-9013 - Remove person from Service case

update intakeservicerequestactor set activeflag = 0, updatedby = 'CDM-9013', updatedon = now() where intakeservicerequestactorid ='287c22f7-d0d8-494e-9f80-35225ab25f8b' and activeflag = 1;