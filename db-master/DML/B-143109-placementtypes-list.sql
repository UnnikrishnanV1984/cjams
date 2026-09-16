
DELETE FROM referencevalues WHERE referencetypeid = 10008 AND ref_key IN ('PT_FNC', 'PT_RKC', 'PT_PRFH','PT_ALU','PT_D','PT_IL','PT_MB','PT_MFGH','PT_MFT','PT_QRTP','PT_R','PT_RGH','PT_RTC','PT_TFC','PT_TGH');

INSERT INTO referencevalues (ref_key,referencetypeid,value_text,description,teamtypekey,activeflag,displayorder,insertedby,insertedon,updatedby,updatedon,parenttypeid,parentkey,mdmcode) VALUES
('PT_FNC',10008,'Formal Kinship Care','Formal Kinship Care','CW',1,1,'B-124659',now(),'B-124659',now(),NULL,NULL,NULL);

INSERT INTO referencevalues (ref_key,referencetypeid,value_text,description,teamtypekey,activeflag,displayorder,insertedby,insertedon,updatedby,updatedon,parenttypeid,parentkey,mdmcode) VALUES
('PT_RKC',10008,'Restrictive Kinship Care','Restrictive Kinship Care','CW',1,1,'B-124659',now(),'B-124659',now(),NULL,NULL,NULL);

INSERT INTO referencevalues (ref_key,referencetypeid,value_text,description,teamtypekey,activeflag,displayorder,insertedby,insertedon,updatedby,updatedon,parenttypeid,parentkey,mdmcode) VALUES
('PT_PRFH',10008,'Public Resource (Foster) Home','Public Resource (Foster) Home','CW',1,1,'B-124659',now(),'B-124659',now(),NULL,NULL,NULL);

INSERT INTO referencevalues (ref_key,referencetypeid,value_text,description,teamtypekey,activeflag,displayorder,insertedby,insertedon,updatedby,updatedon,parenttypeid,parentkey,mdmcode) VALUES
('PT_TFC',10008,'Treatment Foster Care','Treatment Foster Care','CW',1,1,'B-124659',now(),'B-124659',now(),NULL,NULL,NULL);

INSERT INTO referencevalues (ref_key,referencetypeid,value_text,description,teamtypekey,activeflag,displayorder,insertedby,insertedon,updatedby,updatedon,parenttypeid,parentkey,mdmcode) VALUES
('PT_MFT',10008,'Medically Fragile TFC','Medically Fragile TFC','CW',1,1,'B-124659',now(),'B-124659',now(),NULL,NULL,NULL);

INSERT INTO referencevalues (ref_key,referencetypeid,value_text,description,teamtypekey,activeflag,displayorder,insertedby,insertedon,updatedby,updatedon,parenttypeid,parentkey,mdmcode) VALUES
('PT_MB',10008,'*Mother baby (TFC or Group)','*Mother baby (TFC or Group)','CW',1,1,'B-124659',now(),'B-124659',now(),NULL,NULL,NULL);

INSERT INTO referencevalues (ref_key,referencetypeid,value_text,description,teamtypekey,activeflag,displayorder,insertedby,insertedon,updatedby,updatedon,parenttypeid,parentkey,mdmcode) VALUES
('PT_D',10008,'Diagnostic','Diagnostic','CW',1,1,'B-124659',now(),'B-124659',now(),NULL,NULL,NULL);

INSERT INTO referencevalues (ref_key,referencetypeid,value_text,description,teamtypekey,activeflag,displayorder,insertedby,insertedon,updatedby,updatedon,parenttypeid,parentkey,mdmcode) VALUES
('PT_R',10008,'Respite','Respite','CW',1,1,'B-124659',now(),'B-124659',now(),NULL,NULL,NULL);

INSERT INTO referencevalues (ref_key,referencetypeid,value_text,description,teamtypekey,activeflag,displayorder,insertedby,insertedon,updatedby,updatedon,parenttypeid,parentkey,mdmcode) VALUES
('PT_RGH',10008,'Regular Group Home','Regular Group Home','CW',1,1,'B-124659',now(),'B-124659',now(),NULL,NULL,NULL);

INSERT INTO referencevalues (ref_key,referencetypeid,value_text,description,teamtypekey,activeflag,displayorder,insertedby,insertedon,updatedby,updatedon,parenttypeid,parentkey,mdmcode) VALUES
('PT_TGH',10008,'Therapeutic Group Home','Therapeutic Group Home','CW',1,1,'B-124659',now(),'B-124659',now(),NULL,NULL,NULL);

INSERT INTO referencevalues (ref_key,referencetypeid,value_text,description,teamtypekey,activeflag,displayorder,insertedby,insertedon,updatedby,updatedon,parenttypeid,parentkey,mdmcode) VALUES
('PT_MFGH',10008,'Medically Fragile Group Home','Medically Fragile Group Home','CW',1,1,'B-124659',now(),'B-124659',now(),NULL,NULL,NULL);

INSERT INTO referencevalues (ref_key,referencetypeid,value_text,description,teamtypekey,activeflag,displayorder,insertedby,insertedon,updatedby,updatedon,parenttypeid,parentkey,mdmcode) VALUES
('PT_QRTP',10008,'QRTP','QRTP','CW',1,1,'B-124659',now(),'B-124659',now(),NULL,NULL,NULL);

INSERT INTO referencevalues (ref_key,referencetypeid,value_text,description,teamtypekey,activeflag,displayorder,insertedby,insertedon,updatedby,updatedon,parenttypeid,parentkey,mdmcode) VALUES
('PT_RTC',10008,'Residential Treatment Center','Residential Treatment Center','CW',1,1,'B-124659',now(),'B-124659',now(),NULL,NULL,NULL);

INSERT INTO referencevalues (ref_key,referencetypeid,value_text,description,teamtypekey,activeflag,displayorder,insertedby,insertedon,updatedby,updatedon,parenttypeid,parentkey,mdmcode) VALUES
('PT_ALU',10008,'Alternative Living Unit','Alternative Living Unit','CW',1,1,'B-124659',now(),'B-124659',now(),NULL,NULL,NULL);

INSERT INTO referencevalues (ref_key,referencetypeid,value_text,description,teamtypekey,activeflag,displayorder,insertedby,insertedon,updatedby,updatedon,parenttypeid,parentkey,mdmcode) VALUES
('PT_IL',10008,'Independent Living','Independent Living','CW',1,1,'B-124659',now(),'B-124659',now(),NULL,NULL,NULL);
