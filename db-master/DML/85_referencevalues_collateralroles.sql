UPDATE referencevalues
SET displayorder = 12, updatedon=now()
WHERE ref_key='DOC' AND referencetypeid=175 and activeflag=1;

UPDATE referencevalues
SET displayorder = 2 , updatedon=now()
WHERE ref_key='AM' AND referencetypeid=175 and activeflag=1;

UPDATE referencevalues
SET displayorder = 3 , updatedon=now()
WHERE ref_key='AT' AND referencetypeid=175 and activeflag=1;

UPDATE referencevalues
SET displayorder = 15 , updatedon=now()
WHERE ref_key='FNACS' AND referencetypeid=175 and activeflag=1;

UPDATE referencevalues
SET displayorder = 29 , updatedon=now()
WHERE ref_key='ME' AND referencetypeid=175 and activeflag=1;

UPDATE referencevalues
SET displayorder = 33 , updatedon=now()
WHERE ref_key='PASU' AND referencetypeid=175 and activeflag=1;

UPDATE referencevalues
SET displayorder = 15 , updatedon=now()
WHERE ref_key='FIFA' AND referencetypeid=175 and activeflag=1;

UPDATE referencevalues
SET displayorder = 15 , updatedon=now()
WHERE ref_key='FACS' AND referencetypeid=175 and activeflag=1;

UPDATE referencevalues
SET displayorder = 16 , updatedon=now()
WHERE ref_key='FOPA' AND referencetypeid=175 and activeflag=1;
