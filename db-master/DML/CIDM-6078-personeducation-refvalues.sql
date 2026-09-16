delete from referencevalues where ref_key = 'CFCP' and referencetypeid = 146;

INSERT INTO referencevalues (ref_key,referencetypeid,value_text,description,teamtypekey,activeflag,displayorder,insertedby,insertedon,updatedby,updatedon,parenttypeid,parentkey,mdmcode) 
VALUES ('CFCP',146,'Change in Foster Care Placement','Change in Foster Care Placement','CW',1,1,'CIDM-6078',now(),'CIDM-6078',now(),NULL,NULL,NULL)ON CONFLICT DO NOTHING;