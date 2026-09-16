delete from cjams.referencetype where referencetypeid = 10001;
delete from cjams.referencevalues where referencetypeid = 10001;

INSERT INTO cjams.referencetype (referencetypeid, typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES(10001, 'EBP Utilization Types', 'EBP Utilization Types', 1, 'admin', now(), 'admin',now(), NULL);

INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon) 
VALUES('FT',10001,'Functional Family Therapy','Functional Family Therapy','CW', 1, 1, 'admin', now(), 'admin', now()),
	  ('MT',10001,'Multisystemic Therapy','Multisystemic Therapy','CW', 1, 2, 'admin', now(), 'admin', now()),
	  ('PCIT',10001,'Parent Child Interaction Therapy','Parent Child Interaction Therapy','CW', 1, 3, 'admin', now(), 'admin', now()),
	  ('HFM',10001,'Healthy Families America','Healthy Families America','CW', 1, 4, 'admin', now(), 'admin', now()),
	  ('O',10001,'Other','Other','CW', 1, 5, 'admin', now(), 'admin', now());
	 
delete from cjams.referencevalues where referencetypeid = 516 and (ref_key ='PGAD' or ref_key = 'ADO') ;

INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon) 
VALUES('PGAD', 516, 'Potential Guardianship/Adoption disruption', 'Potential Guardianship/Adoption disruption', 'CW', 1, 9, 'admin', now(), 'admin', now()),
('ADO', 516, 'A direct order', 'A direct order', 'CW', 1, 10, 'admin', now(), 'admin', now());