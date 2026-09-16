-- CDM-12098 Removing the unknown racetypekey
update person set racetypekey = '[{"racetypekey":"WH"}]', updatedby = 'CDM-12098' , updatedon = now() where personid = '8e65a913-467c-4bd0-b3d5-4647258f2a90';    
update personracetypemap set activeflag = 0, updatedby = 'CDM-12098' , updatedon = now() where personracetypemapid = '8e0594c5-4d69-4674-b636-827387af3d03'
