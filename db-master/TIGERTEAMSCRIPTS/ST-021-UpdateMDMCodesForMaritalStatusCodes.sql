-- setting all mdm codes to null
update referencevalues set mdmcode = null , updatedon = now() where referencetypeid = 118;
-- setting mdm codes
update referencevalues set mdmcode = 'DV' , updatedon = now() where referencetypeid = 118 and ref_key in ('DV');
update referencevalues set mdmcode = 'LP' , updatedon = now() where referencetypeid = 118 and ref_key in ('LP');
update referencevalues set mdmcode = 'LS' , updatedon = now() where referencetypeid = 118 and ref_key in ('LS');
update referencevalues set mdmcode = 'MR' , updatedon = now() where referencetypeid = 118 and ref_key in ('MR');
update referencevalues set mdmcode = 'SG' , updatedon = now() where referencetypeid = 118 and ref_key in ('SG');
update referencevalues set mdmcode = 'UN' , updatedon = now() where referencetypeid = 118 and ref_key in ('UK');
update referencevalues set mdmcode = 'WD' , updatedon = now() where referencetypeid = 118 and ref_key in ('WD');