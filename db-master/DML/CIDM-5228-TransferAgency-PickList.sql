--CIDM-5228 Transfer Agency pick list items.


DELETE FROM referencevalues WHERE referencetypeid = 350 AND ref_key IN ('ITNONIVE', 'JJA','MHA', 'OPA', 'PA', 'STIVEA', 'TA');

INSERT INTO referencevalues (ref_key,referencetypeid,value_text,description,teamtypekey,activeflag,displayorder,insertedby,insertedon,updatedby,updatedon,parenttypeid,parentkey,mdmcode) VALUES
('ITNONIVE',350,'Indian Tribe or Tribal Agency (Non-IV-E)','Indian Tribe or Tribal Agency (Non-IV-E)','CW',1,1,'B-130562',now(),'B-130562',now(),NULL,NULL,NULL);

INSERT INTO referencevalues (ref_key,referencetypeid,value_text,description,teamtypekey,activeflag,displayorder,insertedby,insertedon,updatedby,updatedon,parenttypeid,parentkey,mdmcode) VALUES
('JJA',350,'Juvenile Justice Agency','Juvenile Justice Agency','CW',1,1,'B-130562',now(),'B-130562',now(),NULL,NULL,NULL);

INSERT INTO referencevalues (ref_key,referencetypeid,value_text,description,teamtypekey,activeflag,displayorder,insertedby,insertedon,updatedby,updatedon,parenttypeid,parentkey,mdmcode) VALUES
('MHA',350,'Mental Health Agency','Mental Health Agency','CW',1,1,'B-130562',now(),'B-130562',now(),NULL,NULL,NULL);

INSERT INTO referencevalues (ref_key,referencetypeid,value_text,description,teamtypekey,activeflag,displayorder,insertedby,insertedon,updatedby,updatedon,parenttypeid,parentkey,mdmcode) VALUES
('OPA',350,'Other Public Agency','Other Public Agency','CW',1,1,'B-130562',now(),'B-130562',now(),NULL,NULL,NULL);

INSERT INTO referencevalues (ref_key,referencetypeid,value_text,description,teamtypekey,activeflag,displayorder,insertedby,insertedon,updatedby,updatedon,parenttypeid,parentkey,mdmcode) VALUES
('PA',350,'Private Agency','Private Agency','CW',1,1,'B-130562',now(),'B-130562',now(),NULL,NULL,NULL);

INSERT INTO referencevalues (ref_key,referencetypeid,value_text,description,teamtypekey,activeflag,displayorder,insertedby,insertedon,updatedby,updatedon,parenttypeid,parentkey,mdmcode) VALUES
('STIVEA',350,'State Title IV-E Agency','State Title IV-E Agency','CW',1,1,'B-130562',now(),'B-130562',now(),NULL,NULL,NULL);

INSERT INTO referencevalues (ref_key,referencetypeid,value_text,description,teamtypekey,activeflag,displayorder,insertedby,insertedon,updatedby,updatedon,parenttypeid,parentkey,mdmcode) VALUES
('TA',350,'Tribal Agency','Tribal Agency','CW',1,1,'B-130562',now(),'B-130562',now(),NULL,NULL,NULL);
