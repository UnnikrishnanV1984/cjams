-- CDM-9248 - Delet contact note

update progressnote set description = null, updatedby = 'CDM-9248', updatedon = now() where progressnoteid = '74c21654-cebd-4548-b9c1-d726fece088f' and activeflag = 1;