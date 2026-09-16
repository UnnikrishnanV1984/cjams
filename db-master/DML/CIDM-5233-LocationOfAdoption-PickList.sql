--CIDM-5233 Location of Adoption or Guardianship pick list items.


DELETE FROM referencevalues WHERE referencetypeid = 351 AND ref_key IN ('INTER_JAG', 'INTER_CAG', 'INTRA_JAG');

INSERT INTO referencevalues (ref_key,referencetypeid,value_text,description,teamtypekey,activeflag,displayorder,insertedby,insertedon,updatedby,updatedon,parenttypeid,parentkey,mdmcode) VALUES
('INTER_JAG',351,'Interjurisdictional Adoption or Guardianship','Interjurisdictional Adoption or Guardianship','CW',1,1,'B-130377',now(),'B-130377',now(),NULL,NULL,NULL);

INSERT INTO referencevalues (ref_key,referencetypeid,value_text,description,teamtypekey,activeflag,displayorder,insertedby,insertedon,updatedby,updatedon,parenttypeid,parentkey,mdmcode) VALUES
('INTER_CAG',351,'Intercountry Adoption or Guardianship','Intercountry Adoption or Guardianship','CW',1,1,'B-130377',now(),'B-130377',now(),NULL,NULL,NULL);

INSERT INTO referencevalues (ref_key,referencetypeid,value_text,description,teamtypekey,activeflag,displayorder,insertedby,insertedon,updatedby,updatedon,parenttypeid,parentkey,mdmcode) VALUES
('INTRA_JAG',351,'Intrajurisdictional Adoption or Guardianship','Intrajurisdictional Adoption or Guardianship','CW',1,1,'B-130377',now(),'B-130377',now(),NULL,NULL,NULL);