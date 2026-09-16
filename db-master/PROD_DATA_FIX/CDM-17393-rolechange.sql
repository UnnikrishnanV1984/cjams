UPDATE cjams.teammember
SET roletypekey='CWCW', updatedby='CDM-17393', updatedon=now()
WHERE teammemberid='1bfa08b3-b36f-425c-ade1-73ea9ad53c0f'::uuid;

UPDATE cjams.rolemapping
SET  roleid=71,  updatedby='CDM-17393', updatedon=now()
WHERE id=55858871;
