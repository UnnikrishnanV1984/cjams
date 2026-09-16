-- setting all mdm codes to null
update referencevalues set mdmcode = null , updatedon = now() where referencetypeid = 173;
-- setting mdm codes for MDM Phone Types
update referencevalues set mdmcode = 'PERSONAL' , updatedon = now() where referencetypeid = 173 and ref_key in ('CL', 'HM', 'PRI', 'SEC');
update referencevalues set mdmcode = 'BUSINESS' , updatedon = now() where referencetypeid = 173 and ref_key in ('BU','WK');
