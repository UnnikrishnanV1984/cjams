UPDATE referencevalues
SET displayorder=15, updatedon=now()
WHERE ref_key='CHILD' and referencetypeid=176 ;
