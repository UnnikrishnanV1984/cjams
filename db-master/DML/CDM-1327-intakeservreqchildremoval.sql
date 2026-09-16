UPDATE cjams.intakeservreqchildremoval
SET removaltypekey='SHB', updatedon = now(), updatedby = 'CDM-1327' where removalid = 198420;

UPDATE cjams.personrole
SET safehavenbabyflag=1, updatedon = now(), updatedby = 'CDM-1327' WHERE personroleid='1bb96d12-6732-40b4-9633-dfa326c397ca'; 