update referencevalues set value_text = 'Transfer to another non-DHS Agency', description = 'Transfer to another non-DHS Agency', updatedby = 'CIDM-6419', updatedon = now() 
where referencetypeid = 343 and ref_key ='TTONDA' and teamtypekey ='CW' and activeflag = 1;

update referencevalues set value_text = 'Tribal Title IV-E Agency', description = 'Tribal Title IV-E Agency', updatedby = 'CIDM-6419', updatedon = now() 
where referencetypeid = 350 and ref_key ='TA' and teamtypekey ='CW' and activeflag = 1 ;