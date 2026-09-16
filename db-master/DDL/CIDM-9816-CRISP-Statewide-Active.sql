/*
 Issue Description: CRISP State Wide Active Flag
 Category/ Module:  CRISP Interface
 Root cause: Pilot County Approval for State Wide Active
 Fix provided: Disable the active county and make state wide active
 Code fix ticket#: CIDM-9816
 Reason why no related code fix: NA
 */
update referencevalues 
set activeflag = 0, updatedby = 'CIDM-9816', updatedon = now()
where activeflag = 1 and referencetypeid = 500502;

update referencevalues 
set activeflag = 1, updatedby = 'CIDM-9816', updatedon = now()
where activeflag = 0 and referencetypeid = 500502 and ref_key = '9999';