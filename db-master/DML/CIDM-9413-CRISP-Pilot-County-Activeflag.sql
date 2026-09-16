/*
   Issue Description: CIDM-9413
   Category/ Module: Activate pilot county for CRISP UAT
   Root cause: NA
   Pull request# for code fix: NA
   Reason why no related code fix: NA
*/
UPDATE cjams.referencevalues set activeflag = 1, updatedby = 'CIDM-8413', updatedon = now()
where ref_key = '1433' and value_text = 'Carroll' and referencetypeid = 500502;

UPDATE cjams.referencevalues set activeflag = 1, updatedby = 'CIDM-8413', updatedon = now()
where ref_key = '1442' and value_text = 'Montgomery' and referencetypeid = 500502;

UPDATE cjams.referencevalues set activeflag = 1, updatedby = 'CIDM-8413', updatedon = now()
where ref_key = '1440' and value_text = 'Howard' and referencetypeid = 500502;
