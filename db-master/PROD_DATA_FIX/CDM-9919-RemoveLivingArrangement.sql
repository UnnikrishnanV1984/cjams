-- CDM-9919 - Remove living arrangement from the placement history

update livingarrangement set activeflag = 0, updatedby = 'CDM-9919', updatedon = now() where livingid = '32a5856e-5755-4c12-b77c-569bc83454c3' and activeflag = 1;

update placement set activeflag=0 where placementid='54f6938e-b893-48ef-b969-56d55b5f9fcf';
