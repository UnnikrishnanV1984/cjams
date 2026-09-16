--B-130562 updated changes for Child Removal End reasons.


update referencevalues set value_text = 'Reunify with Parent or legal guardian', description = 'Reunify with Parent or legal guardian', updatedby = 'B-130562', updatedon = now() 
where referencetypeid = 343 and ref_key ='REUNIF' and teamtypekey ='CW' and activeflag = 1;

update referencevalues set value_text = 'Transfer to another Agency', description = 'Transfer to another Agency', updatedby = 'B-130562', updatedon = now() 
where referencetypeid = 343 and ref_key ='TTONDA' and teamtypekey ='CW' and activeflag = 1;

update referencevalues set value_text = 'Death of Child', description = 'Death of Child', updatedby = 'B-130562', updatedon = now() 
where referencetypeid = 343 and ref_key ='DEATHOC' and teamtypekey ='CW' and activeflag = 1;

update referencevalues set value_text = 'Runaway or Whereabouts Unknown', description = 'Runaway or Whereabouts Unknown', updatedby = 'B-130562', updatedon = now() 
where referencetypeid = 343 and ref_key ='RNAWAY' and teamtypekey ='CW' and activeflag = 1;

delete from referencevalues where ref_key = 'LWOR' and referencetypeid = 343 and teamtypekey='CW';

INSERT INTO referencevalues (ref_key,referencetypeid,value_text,description,teamtypekey,activeflag,displayorder,insertedby,insertedon,updatedby,updatedon,parenttypeid,parentkey,mdmcode) VALUES
('LWOR',343,'Live with other relative','Live with other relative','CW',1,1,'B-130562',now(),'B-130562',now(),NULL,NULL,NULL);

