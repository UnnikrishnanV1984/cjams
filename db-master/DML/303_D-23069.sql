UPDATE referencevalues rv1 
SET 
rv1.ref_key = (SELECT description FROM referencevalues rv2 WHERE rv2.ref_key = rv1.ref_key AND referencetypeid=146),
rv1.updatedon = now()
WHERE 
referencetypeid = 146;