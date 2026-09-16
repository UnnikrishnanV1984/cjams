-- CDM-8965 - Remove person from Service case

update intakeservicerequestactor set activeflag = 0, updatedby = 'CDM-8965', updatedon = now() where intakeservicerequestactorid ='f4b7a512-3619-4006-a6ed-1246f9fb31af' and activeflag = 1;