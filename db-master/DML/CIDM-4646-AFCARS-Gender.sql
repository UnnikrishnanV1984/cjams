/*

Gender Changes For Person tab

*/



update referencevalues  set activeflag =0, updatedby = 'CIDM-4646', updatedon = now() where ref_key  ='U' and referencetypeid  =301;


update referencevalues  set activeflag =0, updatedby = 'CIDM-4646', updatedon = now() where ref_key  ='TG' and referencetypeid  =301;