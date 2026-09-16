-- setting all mdm codes to null
update referencevalues set mdmcode = null where referencetypeid = 172;
-- setting mdm codes for MDM address Types
update referencevalues set mdmcode = 'MAI' where referencetypeid = 172 and ref_key in ('MAI');
update referencevalues set mdmcode = 'RES' where referencetypeid = 172 and ref_key in ('HO','PH','RES','SH');
update referencevalues set mdmcode = 'WRK' where referencetypeid = 172 and ref_key in ('BU','WO');