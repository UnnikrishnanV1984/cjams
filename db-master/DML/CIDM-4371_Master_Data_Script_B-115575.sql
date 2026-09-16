-- B-115575 CW- Do Not Expunge- CIDM-4371

/*
Master Data for Do not Expunge Justification

LHR: Litigation Hold Released (approved by supervisor and AD)
ARL: Appeals Resolved (approved by supervisor)
*/

-- Before
delete from referencetype where referencetypeid = 5000 and insertedby = 'CIDM-4371' ;
delete from referencevalues where referencetypeid = 5000 and insertedby = 'CIDM-4371' ;


-- Before
select * from referencetype where referencetypeid = 5000 ;
select * from referencevalues where referencetypeid = 5000 ;

INSERT INTO cjams.referencetype
	(	referencetypeid, typedescription, tablename, activeflag, 
		insertedby, insertedon, updatedby, updatedon, flag
	)
VALUES
	(	5000, 'Do not Expunge Justification', 'Do not Expunge Justification', 1, 
		'CIDM-4371', now(), 'CIDM-4371', now(), NULL
	);

INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text,
		description, teamtypekey, activeflag, displayorder, 
		insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'ARL', 5000, 'Appeals Resolved', 
		'Appeals Resolved', 'CW', 1, 1, 
		'CIDM-4371', now(), 'CIDM-4371', now(), NULL, NULL, NULL
	);

INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text,
		description, teamtypekey, activeflag, displayorder, 
		insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'LHR', 5000, 'Litigation Hold Released', 
		'Litigation Hold Released', 'CW', 1, 2, 
		'CIDM-4371', now(), 'CIDM-4371', now(), NULL, NULL, NULL
	);

-- After
select * from referencetype where referencetypeid = 5000 ;
select * from referencevalues where referencetypeid = 5000 ;
