update referencevalues set teamtypekey = null where referencetypeid = 76;
update referencevalues set teamtypekey = 'AS' where referencetypeid = 76 and ref_key in ('BP', 'MH', 'UNK');
update referencevalues set value_text = 'DJS Funded Facility/not detention', description = 'DJS Funded Facility/not detention' where referencetypeid = 76 and ref_key = 'DJS';
update referencevalues set activeflag = 1, teamtypekey = 'CW' where referencetypeid = 76 and ref_key = 'FSMPH';
update referencevalues set activeflag = 1, teamtypekey = 'CW' where referencetypeid = 76 and ref_key = 'HH';
update referencevalues set activeflag = 1, teamtypekey = 'CW' where referencetypeid = 76 and ref_key = 'IFHI';
update referencevalues set value_text = 'ICPC Foster Home - Incoming', description = 'ICPC Foster Home - Incoming' where referencetypeid = 76 and ref_key = 'IFHI';
update referencevalues set activeflag = 1, teamtypekey = 'CW', description = 'Father''s Home' where referencetypeid = 76 and ref_key = 'FH';
update referencevalues set activeflag = 0 where referencetypeid = 76 and ref_key in ('IMCNA', 'IPC');

delete from  referencevalues where referencetypeid = 76 and ref_key in ('FSMPH', 'FCH', 'FCNFHS', 'HMLS', 'HMLSSTR', 'IAHI', 'IMC', 'MOBP', 'MOH', 'MOFH', 'MOSFPH');

INSERT INTO referencevalues (ref_key,referencetypeid,value_text,description,teamtypekey,activeflag,displayorder,insertedby,insertedon,updatedby,updatedon) VALUES
	 ('FSMPH',76,'Father & Step Mother/Paramour Home','Father & Step Mother/Paramour Home','CW',1,27,'B-72329',now(),'B-72329',now()),
	 ('FCH',76,'Foster Care - Home','Foster Care - Home','CW',1,28,'B-72329',now(),'B-72329',now()),
	 ('FCNFHS',76,'Foster Care - Non-Foster Home setting','Foster Care - Non-Foster Home setting','CW',1,29,'B-72329',now(),'B-72329',now()),
	 ('HMLS',76,'Homeless','Homeless','CW',1,30,'B-72329',now(),'B-72329',now()),
	 ('HMLSSTR',76,'Homeless Shelter','Homeless Shelter','CW',1,31,'B-72329',now(),'B-72329',now()),
	 ('IAHI',76,'ICPC Adoptive Home – Incoming','ICPC Adoptive Home – Incoming','CW',1,32,'B-72329',now(),'B-72329',now()),
	 ('IMC',76,'Inpatient Medical Care','Inpatient Medical Care','CW',1,33,'B-72329',now(),'B-72329',now()),
	 ('MOBP',76,'Mother/Baby Program','Mother/Baby Program','CW',1,34,'B-72329',now(),'B-72329',now()),
	 ('MOH',76,'Mother’s Home','Mother’s Home','CW',1,35,'B-72329',now(),'B-72329',now()),
	 ('MOFH',76,'Mother & Father’s Home','Mother & Father’s Home','CW',1,36,'B-72329',now(),'B-72329',now()),
	 ('MOSFPH',76,'Mother & Step Father/Paramour Home','Mother & Step Father/Paramour Home','CW',1,37,'B-72329',now(),'B-72329',now());