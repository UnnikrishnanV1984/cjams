/*
   Race
   Unknown is already displaying, so no changes.
*/

update referencevalues  set activeflag =1, updatedby = 'CIDM-4645', updatedon = now()  where ref_key  ='AB' and referencetypeid  =171;

update referencevalues  set activeflag =1, updatedby = 'CIDM-4645', updatedon = now() where ref_key  ='DC' and referencetypeid  =171;

update referencevalues  set activeflag =0, updatedby = 'CIDM-4645', updatedon = now() where ref_key  ='LA' and referencetypeid  =171;



/*
   Ethnicity
*/

update referencevalues  set activeflag =1, updatedby = 'CIDM-4645', updatedon = now() where ref_key  ='A' and referencetypeid  =300;

update referencevalues  set activeflag =1, updatedby = 'CIDM-4645', updatedon = now() where ref_key  ='D' and referencetypeid  =300;