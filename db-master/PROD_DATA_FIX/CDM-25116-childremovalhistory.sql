--CDM-25116
update intakeservreqchildremoval 
set activeflag = 0, updatedby = 'CDM-25116', updatedon= now()
where personid = '87bde23b-9cf5-4090-b180-81a74e004551' and intakeservreqchildremovalid in ('133ef9ee-82a5-4725-81eb-70b616158eff', 'bafb39f6-cb30-4229-8e13-0f30c5139807');;
