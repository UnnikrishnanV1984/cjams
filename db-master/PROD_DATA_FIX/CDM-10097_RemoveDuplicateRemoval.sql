-- CDM-10097 - Remove duplicate child removal record

update intakeservreqchildremoval set activeflag=0, updatedon = now(), updatedby = 'CDM-10097' where intakeservreqchildremovalid='59754f22-f2de-4476-8648-484d19cfcf69';
