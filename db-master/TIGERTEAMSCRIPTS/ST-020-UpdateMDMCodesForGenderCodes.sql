-- setting all mdm codes to null
update referencevalues set mdmcode = null , updatedon = now() where referencetypeid = 301;
-- setting mdm codes for MDM Phone Types
update referencevalues set mdmcode = 'F' , updatedon = now() where referencetypeid = 301 and ref_key in ('F');
update referencevalues set mdmcode = 'M' , updatedon = now() where referencetypeid = 301 and ref_key in ('M');
update referencevalues set mdmcode = 'O' , updatedon = now() where referencetypeid = 301 and ref_key in ('O','TG','TGIF','TGIM');
update referencevalues set mdmcode = 'U' , updatedon = now() where referencetypeid = 301 and ref_key in ('U');