UPDATE cjams.teammember
SET roletypekey='CWSP', updatedby='CDM-18875', updatedon=now()
WHERE teammemberid='1989818e-2133-49e1-b9e1-3a8840300854'::uuid;

UPDATE cjams.rolemapping
SET  roleid=36,  updatedby='CDM-18875', updatedon=now()
WHERE id=62700011;
