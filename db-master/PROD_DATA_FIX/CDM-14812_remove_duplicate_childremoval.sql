UPDATE intakeservreqchildremoval 
SET updatedby = 'CDM-14812', 
	updatedon = now(), 
	activeflag = 0
WHERE intakeservreqchildremovalid = '7cdab138-7207-457c-ad6f-89cb7f8f4775' AND activeflag=1;

UPDATE placement 
SET activeflag = 0, 
	updatedby = 'CDM-14812', 
	updatedon = now() 
WHERE placementid in ('604627b2-94d0-4b57-95ed-0db5f4917447', '3d8a0263-e48a-4ad0-be1d-e54a467e7d84', '627367de-b483-4645-8180-7db76ba5f105');
