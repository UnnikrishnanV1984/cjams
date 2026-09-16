-- CDM=10883 - Update the removal type for child removal

update intakeservreqchildremoval set removaltypekey = 'CDVP', updatedby = 'CDM-10883', updatedon = now() where intakeservreqchildremovalid ='f9c90122-04af-4afb-a123-8104afb2f650';
