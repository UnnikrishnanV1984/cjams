-- setting all mdm codes to null
update referencevalues set mdmcode = null , updatedon = now() where referencetypeid = 300;
-- setting mdm codes
update referencevalues set mdmcode = 'H' , updatedon = now() where referencetypeid = 300 and ref_key in ('H');
update referencevalues set mdmcode = 'X' , updatedon = now() where referencetypeid = 300 and ref_key in ('X');
update referencevalues set mdmcode = 'U' , updatedon = now() where referencetypeid = 300 and ref_key in ('U');
update referencevalues set mdmcode = 'D' , updatedon = now() where referencetypeid = 300 and ref_key in ('D');