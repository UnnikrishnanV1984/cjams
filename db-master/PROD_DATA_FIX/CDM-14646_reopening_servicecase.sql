UPDATE servicecase 
SET statustypekey ='Open', dispositioncode = 'Open', enddate = null, updatedby = 'CDM-14646',updatedon = now() 
WHERE servicecaseid = 'b6049d66-c043-4776-8742-ffae01d2c810';

update servicecasedisposition 
set activeflag = 0, updatedby = 'CDM-14646',updatedon = now() 
where servicecasedispositionid = '974bf14a-0bcb-4cc8-b173-d3a003535f4a';

update personprogramarea set enddate = null, updatedby = 'CDM-14646', updatedon = now() 
where personprogramid in ('05588dc1-713e-41bc-99c0-16a699be5e43');
