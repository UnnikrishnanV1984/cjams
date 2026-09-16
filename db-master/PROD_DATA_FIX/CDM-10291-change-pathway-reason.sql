update intakeservicerequestsdm 
set isar = true,
updatedon = now(),
updatedby = 'CDM-10291'
where intakeserviceid = 'c3aff1cc-f8b3-45c6-ac0d-87ee19e9b89e';
