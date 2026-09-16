-- CDM-8036 - Add end date for Child removal and exitreason

update intakeservreqchildremoval set exitdate = '2020-07-28 14:00:25', removalexitreason = 'RUF', updatedby = 'CDM=8036', updatedon = now() where intakeservreqchildremovalid = '3167cf96-172b-4ee8-8911-2a8b4fce046a';
