--B-126246 update marital status fields

UPDATE referencevalues SET value_text = 'Married', description = 'Married', updatedby = 'B-126246', updatedon = now() 
WHERE referencetypeid = 118 and activeflag = 1 and ref_key = 'MR';

delete from referencevalues where ref_key = 'UMC' and referencetypeid = 118;

-- INSERT INTO referencevalues (ref_key,referencetypeid,value_text,description,teamtypekey,activeflag,displayorder,insertedby,insertedon,updatedby,updatedon,parenttypeid,parentkey,mdmcode) VALUES
-- 	 ('UMC',118,'Unmarried Couple','Unmarried Couple',NULL,1,null,'B-126246',now(),'B-126246',now(),NULL,NULL,NULL);
