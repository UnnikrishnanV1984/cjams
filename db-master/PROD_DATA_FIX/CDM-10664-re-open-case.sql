Update servicecase SET statustypekey = 'Open', dispositioncode = 'Open', enddate = null, updatedby = 'CDM-10664',updatedon = now() WHERE servicecaseid = 'de710b3c-f3a8-4ff5-9b10-d637bc4cbb2d';

Update servicecasedisposition SET activeflag = 0, updatedby = 'CDM-10664',updatedon = now() where servicecasedispositionid = 'a250e4ff-f3d4-4918-8e5e-76b9ec5b22ec';

update intakeservreqchildremoval set removalexitreason= null, exitdate = null, returndate = null, returntime = null, updatedby = 'CDM-10664',updatedon = now() where intakeservreqchildremovalid = '5f1cdd2c-7dd5-47cc-8632-db90131e9c0e';

update placement set enddatetime = null, updatedby = 'CDM-10664', updatedon = now() where placementid = '4193305f-d395-4cf7-9b70-3f6a335bc8e0';

update personprogramarea set enddate = null, updatedby = 'CDM-10664', updatedon = now() where personprogramid = '59ce7569-5699-4b01-a8d6-a5959c81a7a6';
