-- setting all mdm codes to null
update referencevalues set mdmcode = null , updatedon = now() where referencetypeid = 171;
-- setting mdm codes
update referencevalues set mdmcode = 'AB' , updatedon = now() where referencetypeid = 171 and ref_key in ('AB');
update referencevalues set mdmcode = 'AI' , updatedon = now() where referencetypeid = 171 and ref_key in ('AI');
update referencevalues set mdmcode = 'AI' , updatedon = now() where referencetypeid = 171 and ref_key in ('AN');
update referencevalues set mdmcode = 'AS' , updatedon = now() where referencetypeid = 171 and ref_key in ('AS');
update referencevalues set mdmcode = 'BA' , updatedon = now() where referencetypeid = 171 and ref_key in ('BA');
update referencevalues set mdmcode = 'DC' , updatedon = now() where referencetypeid = 171 and ref_key in ('DC');
update referencevalues set mdmcode = 'PI' , updatedon = now() where referencetypeid = 171 and ref_key in ('PI');
update referencevalues set mdmcode = 'UN' , updatedon = now() where referencetypeid = 171 and ref_key in ('UN');
update referencevalues set mdmcode = 'WH' , updatedon = now() where referencetypeid = 171 and ref_key in ('WH');