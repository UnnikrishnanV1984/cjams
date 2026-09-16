-- CDM-10000 - Activate case plan

update snapshothist set activeflag = 1, updatedby = 'CDM-10000', updatedon = now() where id='3518bc40-d5a4-4791-85d9-a6f5c719ec8b' and activeflag = 0;