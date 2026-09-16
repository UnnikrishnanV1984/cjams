-- CDM-9334 - Add Removal reason

update intakeservreqchildremoval set removalexitreason = 'EMANIND', updatedby = 'CDM-9334', updatedon = now() where  intakeservreqchildremovalid ='7f683633-439f-40ff-a269-2f5ee1a844cf' and activeflag =1;
