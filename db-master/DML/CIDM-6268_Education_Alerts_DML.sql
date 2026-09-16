-- B-129401 - PI33 - Sprint 05-Enhancement to Education Alert (CIDM-6268)
-- Master Data to add new referencevalues for Person Education Alert Actions (Hold & Stop)

-- Delete 
Delete from referencetype where referencetypeid in ( 589, 590 );

Delete from referencevalues where referencetypeid in ( 589, 590 );


-- 589 - Hold education Alerts - Start
-- Not school age
-- Runaway
-- In Adult Detention Center
INSERT INTO cjams.referencetype
	(	referencetypeid, typedescription, tablename, 
		activeflag, insertedby, insertedon, updatedby, updatedon, flag
	)
VALUES
	(	589, 'Reason for Hold education Alerts', 'personeducationalertactions', 
		1, 'CIDM-6268', now(), 'CIDM-6268', now(), NULL 
	);


INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'PHNSA', 589, 'Not School Age', 'Not School Age', 
		'CW', 1, 1, 'CIDM-6268', now(), 'CIDM-6268', now(), NULL, NULL, NULL
	);
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'PHRNW', 589, 'Runaway', 'Runaway', 
		'CW', 1, 1, 'CIDM-6268', now(), 'CIDM-6268', now(), NULL, NULL, NULL
	);	

INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'PHADC', 589, 'In Adult Detention Center', 'In Adult Detention Center', 
		'CW', 1, 1, 'CIDM-6268', now(), 'CIDM-6268', now(), NULL, NULL, NULL
	);	
	
-- 589 - Hold education alerts - End
-- Graduated(High School)
-- Graduated(Post-Secondary/Vocational Training)
-- Dropped Out(High School)
-- Dropped Out(Post-Secondary/Vocational Training)
-- 590 - Stop All Education Alerts - Start
INSERT INTO cjams.referencetype
	(	referencetypeid, typedescription, tablename, 
		activeflag, insertedby, insertedon, updatedby, updatedon, flag
	)
VALUES
	(	590, 'Reason for Stop All Education Alerts', 'personeducationalertactions', 
		1, 'CIDM-6268', now(), 'CIDM-6268', now(), NULL 
	);
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'PSGHS', 590, 'Graduated (High School)', 'Graduated (High School)', 
		'CW', 1, 1, 'CIDM-6268', now(), 'CIDM-6268', now(), NULL, NULL, NULL
	);		

INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'PSPVT', 590, 'Graduated (Post-Secondary/Vocational Training)', 'Graduated (Post-Secondary/Vocational Training)', 
		'CW', 1, 1, 'CIDM-6268', now(), 'CIDM-6268', now(), NULL, NULL, NULL
	);	
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'PSDHS', 590, 'Dropped Out (High School)', 'Dropped Out (High School)', 
		'CW', 1, 1, 'CIDM-6268', now(), 'CIDM-6268', now(), NULL, NULL, NULL
	);	
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'PSDPT', 590, 'Dropped Out (Post-Secondary/Vocational Training)', 'Dropped Out (Post-Secondary/Vocational Training)', 
		'CW', 1, 1, 'CIDM-6268', now(), 'CIDM-6268', now(), NULL, NULL, NULL
	);	
	
-- 590 - Stop All Education Alerts - End