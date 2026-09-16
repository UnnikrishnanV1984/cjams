/*  
   Person Search User Story - Changing Fuzzy Display Order
   Codefix ticket: CIDM-10748
*/
update cjams.referencevalues 
set displayorder=2,
    updatedby = 'CIDM-10748',
    updatedon = now() 
where ref_key IN ('FZM') AND referencetypeid = 500200;