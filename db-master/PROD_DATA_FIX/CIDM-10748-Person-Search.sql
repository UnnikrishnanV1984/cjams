/*
   Issue Description: CIDM-10748
   Category/ Module  : Person Search Search Type
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Need to do data fix
*/
UPDATE cjams.referencevalues
SET
    activeflag = 0,
    updatedby = 'CIDM-10748',
    updatedon = now()
WHERE ref_key='EXP' AND referencetypeid = 500200;