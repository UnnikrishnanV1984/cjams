-- B-144171 - Response Timer Delay (CIDM-5447)
-- Master Data to add new Reasons for Response Timer Delay

-- Delete 
Delete from referencetype where referencetypeid in ( 580, 581, 582, 583, 584, 585, 586, 587, 588 );

Delete from referencevalues where referencetypeid in ( 580, 581, 582, 583, 584, 585, 586, 587, 588 );

-- Add
-- Alleged victim - Start
-- Alleged victim 1st dropdown - Start 
INSERT INTO cjams.referencetype
	(	referencetypeid, typedescription, tablename, 
		activeflag, insertedby, insertedon, updatedby, updatedon, flag
	)
VALUES
	(	580, 'Alleged victim Response Timer Delay Reason I', 'cpsresponsetimeractions', 
		1, 'CIDM-5447', now(), 'CIDM-5447', now(), NULL 
	);

INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'VAVU', 580, 'Alleged victim Unavailable', 'Alleged victim Unavailable', 
		'CW', 1, 1, 'CIDM-5447', now(), 'CIDM-5447', now(), NULL, NULL, NULL
	);

INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'VCNT', 580, 'Case not assigned timely', 'Case not assigned timely', 
		'CW', 1, 2, 'CIDM-5447', now(), 'CIDM-5447', now(), NULL, NULL, NULL
	);

INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'VCOJ', 580, 'Child out of the jurisdiction', 'Child out of the jurisdiction', 
		'CW', 1, 3, 'CIDM-5447', now(), 'CIDM-5447', now(), NULL, NULL, NULL
	);

INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'VDER', 580, 'Data entry error but face to face met mandate', 'Data entry error but face to face met mandate', 
		'CW', 1, 4, 'CIDM-5447', now(), 'CIDM-5447', now(), NULL, NULL, NULL
	);
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'VEPC', 580, 'Emergency situation prevented initial contact', 'Emergency situation prevented initial contact', 
		'CW', 1, 5, 'CIDM-5447', now(), 'CIDM-5447', now(), NULL, NULL, NULL
	);
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'VFCD', 580, 'Family refused to cooperate with Department', 'Family refused to cooperate with Department', 
		'CW', 1, 6, 'CIDM-5447', now(), 'CIDM-5447', now(), NULL, NULL, NULL
	);	
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'VISR', 580, 'Initial contact with family would place child''s safety at risk', 'Initial contact with family would place child''s safety at risk', 
		'CW', 1, 7, 'CIDM-5447', now(), 'CIDM-5447', now(), NULL, NULL, NULL
	);
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'VWCR', 580, 'Worker assigned multiple cases all requiring 24 hour response', 'Worker assigned multiple cases all requiring 24 hour response', 
		'CW', 1, 8, 'CIDM-5447', now(), 'CIDM-5447', now(), NULL, NULL, NULL
	);
-- Alleged victim 1st dropdown - End
	
-- Alleged victim 2nd dropdown - Start
INSERT INTO cjams.referencetype
	(	referencetypeid, typedescription, tablename, 
		activeflag, insertedby, insertedon, updatedby, updatedon, flag
	)
VALUES
	(	581, 'Alleged victim Response Timer Delay Reason II', 'cpsresponsetimeractions', 
		1, 'CIDM-5447', now(), 'CIDM-5447', now(), NULL 
	);

-- If 1st dropdown is selected with value is Alleged victim Unavailable -- VAVU
-- 2nd dropdown:
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'VAFF', 581, 'Attempted Face to Face', 'Attempted Face to Face', 
		'CW', 1, 1, 'CIDM-5447', now(), 'CIDM-5447', now(), 580, 'VAVU', NULL
	);
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'VFCM', 581, 'Family was contacted but unavailable to meet within mandate', 'Family was contacted but unavailable to meet within mandate', 
		'CW', 1, 2, 'CIDM-5447', now(), 'CIDM-5447', now(), 580, 'VAVU', NULL
	);	
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'VIIR', 581, 'Insufficient information reported - attempts were made to obtain', 'Insufficient information reported - attempts were made to obtain', 
		'CW', 1, 3, 'CIDM-5447', now(), 'CIDM-5447', now(), 580, 'VAVU', NULL
	);	

-- If 1st dropdown is selected with Child out of the jurisdiction - VCOJ
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'VFTJ', 581, 'Family was out of area for a temporary period of time that exceeded the mandate', 'Family was out of area for a temporary period of time that exceeded the mandate', 
		'CW', 1, 4, 'CIDM-5447', now(), 'CIDM-5447', now(), 580, 'VCOJ', NULL
	);	
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'VROJ', 581, 'ROA pending - Family is out of State', 'ROA pending - Family is out of State', 
		'CW', 1, 5, 'CIDM-5447', now(), 'CIDM-5447', now(), 580, 'VCOJ', NULL
	);		

INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'VRIJ', 581, 'ROA pending - In-state but other LDSS was unable to see alleged victim within mandate', 'ROA pending - In-state but other LDSS was unable to see alleged victim within mandate', 
		'CW', 1, 6, 'CIDM-5447', now(), 'CIDM-5447', now(), 580, 'VCOJ', NULL
	);	
	
-- If 1st dropdown is selected with value as Worker assigned multiple cases all requiring 24 hour response - VWCR
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'VAWR', 581, 'After Hours worker unable to meet mandate for assigned worker', 'After Hours worker unable to meet mandate for assigned worker', 
		'CW', 1, 7, 'CIDM-5447', now(), 'CIDM-5447', now(), 580, 'VWCR', NULL
	);	

INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'VPMR', 581, 'Police called for welfare check but unable to meet mandate', 'Police called for welfare check but unable to meet mandate', 
		'CW', 1, 8, 'CIDM-5447', now(), 'CIDM-5447', now(), 580, 'VWCR', NULL
	);	
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'VSSR', 581, 'Supervisor consulted and other staff were not available', 'Supervisor consulted and other staff were not available', 
		'CW', 1, 9, 'CIDM-5447', now(), 'CIDM-5447', now(), 580, 'VWCR', NULL
	);		
	
-- If 1st dropdown is selected with value as Case not assigned timely - VCNT
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'VDET', 581, 'Data entry error', 'Data entry error', 
		'CW', 1, 10, 'CIDM-5447', now(), 'CIDM-5447', now(), 580, 'VCNT', NULL
	);	

INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'VSDT', 581, 'Supervisor delays', 'Supervisor delays', 
		'CW', 1, 11, 'CIDM-5447', now(), 'CIDM-5447', now(), 580, 'VCNT', NULL
	);		
	
-- If 1st dropdown is selected with value as Family refused to cooperate with Department -- VFCD
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'VDID', 581, 'Department requested court involvement', 'Department requested court involvement', 
		'CW', 1, 12, 'CIDM-5447', now(), 'CIDM-5447', now(), 580, 'VFCD', NULL
	);

INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'VIID', 581, 'Insufficient risk to warrant court involvement', 'Insufficient risk to warrant court involvement', 
		'CW', 1, 13, 'CIDM-5447', now(), 'CIDM-5447', now(), 580, 'VFCD', NULL
	);
	
-- If 1st dropdown is selected with value as Emergency situation prevented initial contact -- VEPC
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'VNDC', 581, 'Natural disaster', 'Natural disaster', 
		'CW', 1, 14, 'CIDM-5447', now(), 'CIDM-5447', now(), 580, 'VEPC', NULL
	);

INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'VNEC', 581, 'Non-work related emergency', 'Non-work related emergency', 
		'CW', 1, 15, 'CIDM-5447', now(), 'CIDM-5447', now(), 580, 'VEPC', NULL
	);	
	
-- If 1st dropdown is selected with value as Data entry error but face to face met mandate - VDER
-- 2nd dropdown should give an optional comment field for ticket # to be provided but can be left blank if no ticket was submitted
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'VTKR', 581, 'Ticket #', 'Ticket #', 
		'CW', 1, 16, 'CIDM-5447', now(), 'CIDM-5447', now(), 580, 'VDER', NULL
	);	
	
-- Alleged victim 2nd dropdown - End
	
-- Alleged victim 3rd dropdown - Start
-- If 2nd drop down is selected with value is Attempted Face to Face - VAFF
INSERT INTO cjams.referencetype
	(	referencetypeid, typedescription, tablename, 
		activeflag, insertedby, insertedon, updatedby, updatedon, flag
	)
VALUES
	(	582, 'Alleged victim Response Timer Delay Reason III', 'cpsresponsetimeractions', 
		1, 'CIDM-5447', now(), 'CIDM-5447', now(), NULL 
	);

INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'V12F', 582, '1-2 Attempts', '1-2 Attempts', 
		'CW', 1, 1, 'CIDM-5447', now(), 'CIDM-5447', now(), 581, 'VAFF', NULL
	);	

INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'V34F', 582, '3-4 Attempts', '3-4 Attempts', 
		'CW', 1, 2, 'CIDM-5447', now(), 'CIDM-5447', now(), 581, 'VAFF', NULL
	);		

INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'V5MF', 582, '5 or more Attempts', '5 or more Attempts', 
		'CW', 1, 3, 'CIDM-5447', now(), 'CIDM-5447', now(), 581, 'VAFF', NULL
	);	
	
-- If 2nd dropdown is selected with value Insufficient information reported - attempts were made to obtain - VIIR
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'V12R', 582, '1-2 Attempts', '1-2 Attempts', 
		'CW', 1, 4, 'CIDM-5447', now(), 'CIDM-5447', now(), 581, 'VIIR', NULL
	);	

INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'V34R', 582, '3-4 Attempts', '3-4 Attempts', 
		'CW', 1, 5, 'CIDM-5447', now(), 'CIDM-5447', now(), 581, 'VIIR', NULL
	);	
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'V5MR', 582, '5 or more Attempts', '5 or more Attempts', 
		'CW', 1, 6, 'CIDM-5447', now(), 'CIDM-5447', now(), 581, 'VIIR', NULL
	);	
	
-- If 2nd dropdown is ROA pending - In-state but other LDSS was unable to see alleged victim within mandate - VRIJ
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'VALJ', 582, 'Allegany', 'Allegany', 
		'CW', 1, 7, 'CIDM-5447', now(), 'CIDM-5447', now(), 581, 'VRIJ', NULL
	);	
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'VAAJ', 582, 'Anne Arundel', 'Anne Arundel', 
		'CW', 1, 8, 'CIDM-5447', now(), 'CIDM-5447', now(), 581, 'VRIJ', NULL
	);	
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'VBTJ', 582, 'Baltimore City', 'Baltimore City', 
		'CW', 1, 9, 'CIDM-5447', now(), 'CIDM-5447', now(), 581, 'VRIJ', NULL
	);		
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'VBCJ', 582, 'Baltimore County', 'Baltimore County', 
		'CW', 1, 10, 'CIDM-5447', now(), 'CIDM-5447', now(), 581, 'VRIJ', NULL
	);		
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'VCLJ', 582, 'Calvert', 'Calvert', 
		'CW', 1, 11, 'CIDM-5447', now(), 'CIDM-5447', now(), 581, 'VRIJ', NULL
	);	
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'VCAJ', 582, 'Caroline', 'Caroline', 
		'CW', 1, 12, 'CIDM-5447', now(), 'CIDM-5447', now(), 581, 'VRIJ', NULL
	);	
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'VCRJ', 582, 'Carroll', 'Carroll', 
		'CW', 1, 13, 'CIDM-5447', now(), 'CIDM-5447', now(), 581, 'VRIJ', NULL
	);		
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'VCCJ', 582, 'Cecil', 'Cecil', 
		'CW', 1, 14, 'CIDM-5447', now(), 'CIDM-5447', now(), 581, 'VRIJ', NULL
	);		
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'VCHJ', 582, 'Charles', 'Charles', 
		'CW', 1, 15, 'CIDM-5447', now(), 'CIDM-5447', now(), 581, 'VRIJ', NULL
	);		
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'VDRJ', 582, 'Dorchester', 'Dorchester', 
		'CW', 1, 16, 'CIDM-5447', now(), 'CIDM-5447', now(), 581, 'VRIJ', NULL
	);	
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'VFDJ', 582, 'Frederick', 'Frederick', 
		'CW', 1, 17, 'CIDM-5447', now(), 'CIDM-5447', now(), 581, 'VRIJ', NULL
	);		
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'VGRJ', 582, 'Garrett', 'Garrett', 
		'CW', 1, 18, 'CIDM-5447', now(), 'CIDM-5447', now(), 581, 'VRIJ', NULL
	);		
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'VHRJ', 582, 'Harford', 'Harford', 
		'CW', 1, 19, 'CIDM-5447', now(), 'CIDM-5447', now(), 581, 'VRIJ', NULL
	);		
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'VHOJ', 582, 'Howard', 'Howard', 
		'CW', 1, 20, 'CIDM-5447', now(), 'CIDM-5447', now(), 581, 'VRIJ', NULL
	);		
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'VKTJ', 582, 'Kent', 'Kent', 
		'CW', 1, 21, 'CIDM-5447', now(), 'CIDM-5447', now(), 581, 'VRIJ', NULL
	);		
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'VMOJ', 582, 'Montgomery', 'Montgomery', 
		'CW', 1, 22, 'CIDM-5447', now(), 'CIDM-5447', now(), 581, 'VRIJ', NULL
	);		
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'VPGJ', 582, 'Prince George''s', 'Prince George''s', 
		'CW', 1, 23, 'CIDM-5447', now(), 'CIDM-5447', now(), 581, 'VRIJ', NULL
	);	
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'VQNJ', 582, 'Queen Anne', 'Queen Anne', 
		'CW', 1, 24, 'CIDM-5447', now(), 'CIDM-5447', now(), 581, 'VRIJ', NULL
	);	
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'VSMJ', 582, 'Somerset', 'Somerset', 
		'CW', 1, 25, 'CIDM-5447', now(), 'CIDM-5447', now(), 581, 'VRIJ', NULL
	);	
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'VSTJ', 582, 'St. Mary''s', 'St. Mary''s', 
		'CW', 1, 26, 'CIDM-5447', now(), 'CIDM-5447', now(), 581, 'VRIJ', NULL
	);		
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'VTBJ', 582, 'Talbot', 'Talbot', 
		'CW', 1, 27, 'CIDM-5447', now(), 'CIDM-5447', now(), 581, 'VRIJ', NULL
	);	
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'VWCJ', 582, 'Washington', 'Washington', 
		'CW', 1, 28, 'CIDM-5447', now(), 'CIDM-5447', now(), 581, 'VRIJ', NULL
	);		
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'VWMJ', 582, 'Wicomico', 'Wicomico', 
		'CW', 1, 29, 'CIDM-5447', now(), 'CIDM-5447', now(), 581, 'VRIJ', NULL
	);	
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'VWRJ', 582, 'Worcester', 'Worcester', 
		'CW', 1, 30, 'CIDM-5447', now(), 'CIDM-5447', now(), 581, 'VRIJ', NULL
	);		
-- Alleged victim 3rd dropdown - End	
-- Alleged victim - End

-- Other children - Start
-- Other children 1st dropdown - Start
INSERT INTO cjams.referencetype
	(	referencetypeid, typedescription, tablename, 
		activeflag, insertedby, insertedon, updatedby, updatedon, flag
	)
VALUES
	(	583, 'Other children Response Timer Delay Reason I', 'cpsresponsetimeractions', 
		1, 'CIDM-5447', now(), 'CIDM-5447', now(), NULL 
	);

INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'OCNT', 583, 'Case not assigned timely', 'Case not assigned timely', 
		'CW', 1, 1, 'CIDM-5447', now(), 'CIDM-5447', now(), NULL, NULL, NULL
	);

INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'OCOJ', 583, 'Child out of the jurisdiction', 'Child out of the jurisdiction', 
		'CW', 1, 2, 'CIDM-5447', now(), 'CIDM-5447', now(), NULL, NULL, NULL
	);
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'ODER', 583, 'Data entry error but face to face met mandate', 'Data entry error but face to face met mandate', 
		'CW', 1, 3, 'CIDM-5447', now(), 'CIDM-5447', now(), NULL, NULL, NULL
	);
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'OEPC', 583, 'Emergency situation prevented initial contact', 'Emergency situation prevented initial contact', 
		'CW', 1, 4, 'CIDM-5447', now(), 'CIDM-5447', now(), NULL, NULL, NULL
	);
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'OFCD', 583, 'Family refused to cooperate with Department', 'Family refused to cooperate with Department', 
		'CW', 1, 5, 'CIDM-5447', now(), 'CIDM-5447', now(), NULL, NULL, NULL
	);	
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'OISR', 583, 'Initial contact with family would place child''s safety at risk', 'Initial contact with family would place child''s safety at risk', 
		'CW', 1, 6, 'CIDM-5447', now(), 'CIDM-5447', now(), NULL, NULL, NULL
	);
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'OOCN', 583, 'Other children Unavailable', 'Other children Unavailable', 
		'CW', 1, 7, 'CIDM-5447', now(), 'CIDM-5447', now(), NULL, NULL, NULL
	);	
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'OWCR', 583, 'Worker assigned multiple cases all requiring 24 hour response', 'Worker assigned multiple cases all requiring 24 hour response', 
		'CW', 1, 8, 'CIDM-5447', now(), 'CIDM-5447', now(), NULL, NULL, NULL
	);
-- Other children 1st dropdown - End
	
-- Other children 2nd dropdown - Start
INSERT INTO cjams.referencetype
	(	referencetypeid, typedescription, tablename, 
		activeflag, insertedby, insertedon, updatedby, updatedon, flag
	)
VALUES
	(	584, 'Other children Response Timer Delay Reason II', 'cpsresponsetimeractions', 
		1, 'CIDM-5447', now(), 'CIDM-5447', now(), NULL 
	);

-- If 1st dropdown is selected with value as Other children Unavailable - OOCN
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'OFMN', 584, 'Family was contacted but unavailable to meet within mandate', 'Family was contacted but unavailable to meet within mandate', 
		'CW', 1, 1, 'CIDM-5447', now(), 'CIDM-5447', now(), 583, 'OOCN', NULL
	);
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'OIIN', 584, 'Insufficient information reported - attempts were made to obtain', 'Insufficient information reported - attempts were made to obtain', 
		'CW', 1, 2, 'CIDM-5447', now(), 'CIDM-5447', now(), 583, 'OOCN', NULL
	);
	
-- If 1st dropdown is selected with Child out of the jurisdiction - OCOJ
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'OFMJ', 584, 'Family was out of area for a temporary period of time that exceeded the mandate', 'Family was out of area for a temporary period of time that exceeded the mandate', 
		'CW', 1, 3, 'CIDM-5447', now(), 'CIDM-5447', now(), 583, 'OCOJ', NULL
	);	

INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'ORIJ', 584, 'ROA pending - Family is out of State', 'ROA pending - Family is out of State', 
		'CW', 1, 4, 'CIDM-5447', now(), 'CIDM-5447', now(), 583, 'OCOJ', NULL
	);	

INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'OROJ', 584, 'ROA pending - In-state but other LDSS was unable to see alleged victim within mandate', 'ROA pending - In-state but other LDSS was unable to see alleged victim within mandate', 
		'CW', 1, 5, 'CIDM-5447', now(), 'CIDM-5447', now(), 583, 'OCOJ', NULL
	);		

-- If 1st dropdown is selected with value as Worker assigned multiple cases all requiring 24 hour response - OWCR
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'OAWR', 584, 'After Hours worker unable to meet mandate for assigned worker', 'After Hours worker unable to meet mandate for assigned worker', 
		'CW', 1, 6, 'CIDM-5447', now(), 'CIDM-5447', now(), 583, 'OWCR', NULL
	);	
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'OPMR', 584, 'Police called for welfare check but unable to meet mandate', 'Police called for welfare check but unable to meet mandate', 
		'CW', 1, 7, 'CIDM-5447', now(), 'CIDM-5447', now(), 583, 'OWCR', NULL
	);	

INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'OSSR', 584, 'Supervisor consulted and other staff were not available', 'Supervisor consulted and other staff were not available', 
		'CW', 1, 8, 'CIDM-5447', now(), 'CIDM-5447', now(), 583, 'OWCR', NULL
	);		

-- If 1st dropdown is selected with value as Case not assigned timely -- OCNT
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'ODET', 584, 'Data entry error', 'Data entry error', 
		'CW', 1, 9, 'CIDM-5447', now(), 'CIDM-5447', now(), 583, 'OCNT', NULL
	);	
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'OSDT', 584, 'Supervisor delays', 'Supervisor delays', 
		'CW', 1, 10, 'CIDM-5447', now(), 'CIDM-5447', now(), 583, 'OCNT', NULL
	);	
	
-- If 1st dropdown is selected with value as Family refused to cooperate with Department -- OFCD
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'ODID', 584, 'Department requested court involvement', 'Department requested court involvement', 
		'CW', 1, 11, 'CIDM-5447', now(), 'CIDM-5447', now(), 583, 'OFCD', NULL
	);	
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'OIID', 584, 'Insufficient risk to warrant court involvement', 'Insufficient risk to warrant court involvement', 
		'CW', 1, 12, 'CIDM-5447', now(), 'CIDM-5447', now(), 583, 'OFCD', NULL
	);	
	
-- If 1st dropdown is selected with value as Data entry error but face to face met mandate -- ODER
-- should give a optional comment field for ticket # to be provided but can be left blank if no ticket was submitted
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'OTKR', 584, 'Ticket #', 'Ticket #', 
		'CW', 1, 13, 'CIDM-5447', now(), 'CIDM-5447', now(), 583, 'ODER', NULL
	);	
	
-- If 1st dropdown is selected with value as Emergency situation prevented initial contact -- OEPC
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'ONDC', 584, 'Natural disaster', 'Natural disaster', 
		'CW', 1, 14, 'CIDM-5447', now(), 'CIDM-5447', now(), 583, 'OEPC', NULL
	);	
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'ONEC', 584, 'Non-work related emergency', 'Non-work related emergency', 
		'CW', 1, 15, 'CIDM-5447', now(), 'CIDM-5447', now(), 583, 'OEPC', NULL
	);		
-- Other children 2nd dropdown - End

-- Other children 3rd dropdown - Start
INSERT INTO cjams.referencetype
	(	referencetypeid, typedescription, tablename, 
		activeflag, insertedby, insertedon, updatedby, updatedon, flag
	)
VALUES
	(	585, 'Other children Response Timer Delay Reason III', 'cpsresponsetimeractions', 
		1, 'CIDM-5447', now(), 'CIDM-5447', now(), NULL 
	);

-- If 2nd dropdown is selected with value Insufficient information reported - attempts were made to obtain - OIIN
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'O12N', 585, '1-2 Attempts', '1-2 Attempts', 
		'CW', 1, 1, 'CIDM-5447', now(), 'CIDM-5447', now(), 584, 'OIIN', NULL
	);	
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'O34N', 585, '3-4 Attempts', '3-4 Attempts', 
		'CW', 1, 2, 'CIDM-5447', now(), 'CIDM-5447', now(), 584, 'OIIN', NULL
	);	

INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'O5MN', 585, '5 or more Attempts', '5 or more Attempts', 
		'CW', 1, 3, 'CIDM-5447', now(), 'CIDM-5447', now(), 584, 'OIIN', NULL
	);		

-- If 2nd dropdown is selected with ROA pending - In-state but other LDSS was unable to see alleged victim within mandate - OROJ
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'OALJ', 585, 'Allegany', 'Allegany', 
		'CW', 1, 4, 'CIDM-5447', now(), 'CIDM-5447', now(), 584, 'OROJ', NULL
	);	
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'OAAJ', 585, 'Anne Arundel', 'Anne Arundel', 
		'CW', 1, 5, 'CIDM-5447', now(), 'CIDM-5447', now(), 584, 'OROJ', NULL
	);	
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'OBTJ', 585, 'Baltimore City', 'Baltimore City', 
		'CW', 1, 6, 'CIDM-5447', now(), 'CIDM-5447', now(), 584, 'OROJ', NULL
	);		
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'OBCJ', 585, 'Baltimore County', 'Baltimore County', 
		'CW', 1, 7, 'CIDM-5447', now(), 'CIDM-5447', now(), 584, 'OROJ', NULL
	);		
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'OCLJ', 585, 'Calvert', 'Calvert', 
		'CW', 1, 8, 'CIDM-5447', now(), 'CIDM-5447', now(), 584, 'OROJ', NULL
	);	
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'OCAJ', 585, 'Caroline', 'Caroline', 
		'CW', 1, 9, 'CIDM-5447', now(), 'CIDM-5447', now(), 584, 'OROJ', NULL
	);	
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'OCRJ', 585, 'Carroll', 'Carroll', 
		'CW', 1, 10, 'CIDM-5447', now(), 'CIDM-5447', now(), 584, 'OROJ', NULL
	);		
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'OCCJ', 585, 'Cecil', 'Cecil', 
		'CW', 1, 11, 'CIDM-5447', now(), 'CIDM-5447', now(), 584, 'OROJ', NULL
	);		
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'OCHJ', 585, 'Charles', 'Charles', 
		'CW', 1, 12, 'CIDM-5447', now(), 'CIDM-5447', now(), 584, 'OROJ', NULL
	);		
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'ODRJ', 585, 'Dorchester', 'Dorchester', 
		'CW', 1, 13, 'CIDM-5447', now(), 'CIDM-5447', now(), 584, 'OROJ', NULL
	);	
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'OFDJ', 585, 'Frederick', 'Frederick', 
		'CW', 1, 14, 'CIDM-5447', now(), 'CIDM-5447', now(), 584, 'OROJ', NULL
	);		
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'OGRJ', 585, 'Garrett', 'Garrett', 
		'CW', 1, 15, 'CIDM-5447', now(), 'CIDM-5447', now(), 584, 'OROJ', NULL
	);		
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'OHRJ', 585, 'Harford', 'Harford', 
		'CW', 1, 16, 'CIDM-5447', now(), 'CIDM-5447', now(), 584, 'OROJ', NULL
	);		
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'OHOJ', 585, 'Howard', 'Howard', 
		'CW', 1, 17, 'CIDM-5447', now(), 'CIDM-5447', now(), 584, 'OROJ', NULL
	);		
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'OKTJ', 585, 'Kent', 'Kent', 
		'CW', 1, 18, 'CIDM-5447', now(), 'CIDM-5447', now(), 584, 'OROJ', NULL
	);		
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'OMOJ', 585, 'Montgomery', 'Montgomery', 
		'CW', 1, 19, 'CIDM-5447', now(), 'CIDM-5447', now(), 584, 'OROJ', NULL
	);		
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'OPGJ', 585, 'Prince George''s', 'Prince George''s', 
		'CW', 1, 20, 'CIDM-5447', now(), 'CIDM-5447', now(), 584, 'OROJ', NULL
	);	
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'OQNJ', 585, 'Queen Anne', 'Queen Anne', 
		'CW', 1, 21, 'CIDM-5447', now(), 'CIDM-5447', now(), 584, 'OROJ', NULL
	);	
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'OSMJ', 585, 'Somerset', 'Somerset', 
		'CW', 1, 22, 'CIDM-5447', now(), 'CIDM-5447', now(), 584, 'OROJ', NULL
	);	
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'OSTJ', 585, 'St. Mary''s', 'St. Mary''s', 
		'CW', 1, 23, 'CIDM-5447', now(), 'CIDM-5447', now(), 584, 'OROJ', NULL
	);		
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'OTBJ', 585, 'Talbot', 'Talbot', 
		'CW', 1, 24, 'CIDM-5447', now(), 'CIDM-5447', now(), 584, 'OROJ', NULL
	);	
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'OWCJ', 585, 'Washington', 'Washington', 
		'CW', 1, 25, 'CIDM-5447', now(), 'CIDM-5447', now(), 584, 'OROJ', NULL
	);		
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'OWMJ', 585, 'Wicomico', 'Wicomico', 
		'CW', 1, 26, 'CIDM-5447', now(), 'CIDM-5447', now(), 584, 'OROJ', NULL
	);	
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'OWRJ', 585, 'Worcester', 'Worcester', 
		'CW', 1, 27, 'CIDM-5447', now(), 'CIDM-5447', now(), 584, 'OROJ', NULL
	);
-- Other children 3rd dropdown - End
-- Other children - End

-- Initial contact caregiver - Start
-- Initial contact caregiver 1st dropdown - Start
INSERT INTO cjams.referencetype
	(	referencetypeid, typedescription, tablename, 
		activeflag, insertedby, insertedon, updatedby, updatedon, flag
	)
VALUES
	(	586, 'ICC Response Timer Delay Reason I', 'cpsresponsetimeractions', 
		1, 'CIDM-5447', now(), 'CIDM-5447', now(), NULL 
	);

INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'CCNT', 586, 'Case not assigned timely', 'Case not assigned timely', 
		'CW', 1, 1, 'CIDM-5447', now(), 'CIDM-5447', now(), NULL, NULL, NULL
	);
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'CDER', 586, 'Data entry error but face to face met mandate', 'Data entry error but face to face met mandate', 
		'CW', 1, 2, 'CIDM-5447', now(), 'CIDM-5447', now(), NULL, NULL, NULL
	);
 
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'CEPC', 586, 'Emergency situation prevented initial contact', 'Emergency situation prevented initial contact', 
		'CW', 1, 3, 'CIDM-5447', now(), 'CIDM-5447', now(), NULL, NULL, NULL
	);
 
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'CFCD', 586, 'Family refused to cooperate with Department', 'Family refused to cooperate with Department', 
		'CW', 1, 4, 'CIDM-5447', now(), 'CIDM-5447', now(), NULL, NULL, NULL
	);

INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'CCOJ', 586, 'Initial Contact Caregiver out of the jurisdiction', 'Initial Contact Caregiver out of the jurisdiction', 
		'CW', 1, 5, 'CIDM-5447', now(), 'CIDM-5447', now(), NULL, NULL, NULL
	);

INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'CCCN', 586, 'Initial Contact Caregiver Unavailable', 'Initial Contact Caregiver Unavailable', 
		'CW', 1, 6, 'CIDM-5447', now(), 'CIDM-5447', now(), NULL, NULL, NULL
	);

INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'CISR', 586, 'Initial contact with family would place child''s safety at risk', 'Initial contact with family would place child''s safety at risk', 
		'CW', 1, 7, 'CIDM-5447', now(), 'CIDM-5447', now(), NULL, NULL, NULL
	);

INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'CWCR', 586, 'Worker assigned multiple cases all requiring 24 hour response', 'Worker assigned multiple cases all requiring 24 hour response', 
		'CW', 1, 8, 'CIDM-5447', now(), 'CIDM-5447', now(), NULL, NULL, NULL
	);
-- Initial contact caregiver 1st dropdown - End 
	
-- Initial contact caregiver 2nd dropdown - Start
INSERT INTO cjams.referencetype
	(	referencetypeid, typedescription, tablename, 
		activeflag, insertedby, insertedon, updatedby, updatedon, flag
	)
VALUES
	(	587, 'ICC Response Timer Delay Reason II', 'cpsresponsetimeractions', 
		1, 'CIDM-5447', now(), 'CIDM-5447', now(), NULL 
	);

-- If 1st dropdown is selected with value as Initial Contact Caregiver Unavailable - CCCN
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'CFFN', 587, 'Attempted Face to Face', 'Attempted Face to Face', 
		'CW', 1, 1, 'CIDM-5447', now(), 'CIDM-5447', now(), 586, 'CCCN', NULL
	);

INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'CFMN', 587, 'Family was contacted but unavailable to meet within mandate', 'Family was contacted but unavailable to meet within mandate', 
		'CW', 1, 2, 'CIDM-5447', now(), 'CIDM-5447', now(), 586, 'CCCN', NULL
	);

INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'CIIN', 587, 'Insufficient information reported - attempts were made to obtain', 'Insufficient information reported - attempts were made to obtain', 
		'CW', 1, 3, 'CIDM-5447', now(), 'CIDM-5447', now(), 586, 'CCCN', NULL
	);

-- If 1st dropdown is selected with Initial Contact Caregiver out of the jurisdiction - CCOJ
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'CFMJ', 587, 'Family was out of area for a temporary period of time that exceeded the mandate', 'Family was out of area for a temporary period of time that exceeded the mandate', 
		'CW', 1, 4, 'CIDM-5447', now(), 'CIDM-5447', now(), 586, 'CCOJ', NULL
	);

INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'CROJ', 587, 'ROA pending - Family is out of State', 'ROA pending - Family is out of State', 
		'CW', 1, 5, 'CIDM-5447', now(), 'CIDM-5447', now(), 586, 'CCOJ', NULL
	);
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'CRIJ', 587, 'ROA pending - In-state but other LDSS was unable to see alleged victim within mandate ', 'ROA pending - In-state but other LDSS was unable to see alleged victim within mandate ', 
		'CW', 1, 6, 'CIDM-5447', now(), 'CIDM-5447', now(), 586, 'CCOJ', NULL
	);

-- If 1st dropdown is selected with value as Worker assigned multiple cases all requiring 24 hour response - CWCR
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'CAHR', 587, 'After Hours worker was unable to meet mandate on behalf of assigned worker', 'After Hours worker was unable to meet mandate on behalf of assigned worker', 
		'CW', 1, 7, 'CIDM-5447', now(), 'CIDM-5447', now(), 586, 'CWCR', NULL
	);

INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'CPMR', 587, 'Police were called for wellcheck but unable to meet mandate', 'Police were called for wellcheck but unable to meet mandate', 
		'CW', 1, 8, 'CIDM-5447', now(), 'CIDM-5447', now(), 586, 'CWCR', NULL
	);
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'CSSR', 587, 'Supervisor was consulted and additional staff options were not available', 'Supervisor was consulted and additional staff options were not available', 
		'CW', 1, 9, 'CIDM-5447', now(), 'CIDM-5447', now(), 586, 'CWCR', NULL
	);	
	

-- If 1st dropdown is selected with value as Case not assigned timely -- CCNT
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'CDET', 587, 'Data entry error', 'Data entry error', 
		'CW', 1, 10, 'CIDM-5447', now(), 'CIDM-5447', now(), 586, 'CCNT', NULL
	);

INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'CSDT', 587, 'Supervisor delays', 'Supervisor delays', 
		'CW', 1, 11, 'CIDM-5447', now(), 'CIDM-5447', now(), 586, 'CCNT', NULL
	);
	

-- If 1st dropdown is selected with value as Family refused to cooperate with Department - CFCD
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'CDID', 587, 'Department requested court involvement', 'Department requested court involvement', 
		'CW', 1, 12, 'CIDM-5447', now(), 'CIDM-5447', now(), 586, 'CFCD', NULL
	);

INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'CIID', 587, 'Insufficient risk to warrant court involvement', 'Insufficient risk to warrant court involvement', 
		'CW', 1, 13, 'CIDM-5447', now(), 'CIDM-5447', now(), 586, 'CFCD', NULL
	);

-- If 1st dropdown is selected with value as Data entry error but face to face met mandate - CDER
-- should give a optional comment field for ticket # to be provided but can be left blank if no ticket was submitted
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'CTKR', 587, 'Ticket #', 'Ticket #', 
		'CW', 1, 14, 'CIDM-5447', now(), 'CIDM-5447', now(), 586, 'CDER', NULL
	);
	
-- If 1st dropdown is selected with value as Emergency situation prevented initial contact - CEPC 
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'CNDC', 587, 'Natural disaster', 'Natural disaster', 
		'CW', 1, 15, 'CIDM-5447', now(), 'CIDM-5447', now(), 586, 'CEPC', NULL
	);

INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'CNEC', 587, 'Non-work related emergency', 'Non-work related emergency', 
		'CW', 1, 16, 'CIDM-5447', now(), 'CIDM-5447', now(), 586, 'CEPC', NULL
	);
-- Initial contact caregiver 2nd dropdown - End	

-- Initial contact caregiver 3rd dropdown - Start
INSERT INTO cjams.referencetype
	(	referencetypeid, typedescription, tablename, 
		activeflag, insertedby, insertedon, updatedby, updatedon, flag
	)
VALUES
	(	588, 'ICC Response Timer Delay Reason III', 'cpsresponsetimeractions', 
		1, 'CIDM-5447', now(), 'CIDM-5447', now(), NULL 
	);

-- If 2nd drop down is selected with value Attempted Face to Face - CFFN
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'C12F', 588, '1-2 Attempts', '1-2 Attempts', 
		'CW', 1, 1, 'CIDM-5447', now(), 'CIDM-5447', now(), 587, 'CFFN', NULL
	);
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'C34F', 588, '3-4 Attempts', '3-4 Attempts', 
		'CW', 1, 2, 'CIDM-5447', now(), 'CIDM-5447', now(), 587, 'CFFN', NULL
	);
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'C5MF', 588, '5 or more Attempts', '5 or more Attempts', 
		'CW', 1, 3, 'CIDM-5447', now(), 'CIDM-5447', now(), 587, 'CAFN', NULL
	);	
	
-- If 2nd dropdown is selected with value Insufficient information reported - attempts were made to obtain - CIIN
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'C12N', 588, '1-2 Attempts', '1-2 Attempts', 
		'CW', 1, 4, 'CIDM-5447', now(), 'CIDM-5447', now(), 587, 'CIIN', NULL
	);

INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'C34N', 588, '3-4 Attempts', '3-4 Attempts', 
		'CW', 1, 5, 'CIDM-5447', now(), 'CIDM-5447', now(), 587, 'CIIN', NULL
	);

INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'C5MN', 588, '5 or more Attempts', '5 or more Attempts', 
		'CW', 1, 6, 'CIDM-5447', now(), 'CIDM-5447', now(), 587, 'CIIN', NULL
	);
	
-- If 2nd dropdown is selected with ROA pending - In-state but other LDSS was unable to see alleged victim within mandate -- CRIJ
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'CALJ', 588, 'Allegany', 'Allegany', 
		'CW', 1, 7, 'CIDM-5447', now(), 'CIDM-5447', now(), 587, 'CRIJ', NULL
	);	
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'CAAJ', 588, 'Anne Arundel', 'Anne Arundel', 
		'CW', 1, 8, 'CIDM-5447', now(), 'CIDM-5447', now(), 587, 'CRIJ', NULL
	);	
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'CBTJ', 588, 'Baltimore City', 'Baltimore City', 
		'CW', 1, 9, 'CIDM-5447', now(), 'CIDM-5447', now(), 587, 'CRIJ', NULL
	);		
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'CBCJ', 588, 'Baltimore County', 'Baltimore County', 
		'CW', 1, 10, 'CIDM-5447', now(), 'CIDM-5447', now(), 587, 'CRIJ', NULL
	);		
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'CCLJ', 588, 'Calvert', 'Calvert', 
		'CW', 1, 11, 'CIDM-5447', now(), 'CIDM-5447', now(), 587, 'CRIJ', NULL
	);	
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'CCAJ', 588, 'Caroline', 'Caroline', 
		'CW', 1, 12, 'CIDM-5447', now(), 'CIDM-5447', now(), 587, 'CRIJ', NULL
	);	
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'CCRJ', 588, 'Carroll', 'Carroll', 
		'CW', 1, 13, 'CIDM-5447', now(), 'CIDM-5447', now(), 587, 'CRIJ', NULL
	);		
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'CCCJ', 588, 'Cecil', 'Cecil', 
		'CW', 1, 14, 'CIDM-5447', now(), 'CIDM-5447', now(), 587, 'CRIJ', NULL
	);		
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'CCHJ', 588, 'Charles', 'Charles', 
		'CW', 1, 15, 'CIDM-5447', now(), 'CIDM-5447', now(), 587, 'CRIJ', NULL
	);		
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'CDRJ', 588, 'Dorchester', 'Dorchester', 
		'CW', 1, 16, 'CIDM-5447', now(), 'CIDM-5447', now(), 587, 'CRIJ', NULL
	);	
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'CFDJ', 588, 'Frederick', 'Frederick', 
		'CW', 1, 17, 'CIDM-5447', now(), 'CIDM-5447', now(), 587, 'CRIJ', NULL
	);		
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'CGRJ', 588, 'Garrett', 'Garrett', 
		'CW', 1, 18, 'CIDM-5447', now(), 'CIDM-5447', now(), 587, 'CRIJ', NULL
	);		
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'CHRJ', 588, 'Harford', 'Harford', 
		'CW', 1, 19, 'CIDM-5447', now(), 'CIDM-5447', now(), 587, 'CRIJ', NULL
	);		
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'CHOJ', 588, 'Howard', 'Howard', 
		'CW', 1, 20, 'CIDM-5447', now(), 'CIDM-5447', now(), 587, 'CRIJ', NULL
	);		
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'CKTJ', 588, 'Kent', 'Kent', 
		'CW', 1, 21, 'CIDM-5447', now(), 'CIDM-5447', now(), 587, 'CRIJ', NULL
	);		
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'CMOJ', 588, 'Montgomery', 'Montgomery', 
		'CW', 1, 22, 'CIDM-5447', now(), 'CIDM-5447', now(), 587, 'CRIJ', NULL
	);		
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'CPGJ', 588, 'Prince George''s', 'Prince George''s', 
		'CW', 1, 23, 'CIDM-5447', now(), 'CIDM-5447', now(), 587, 'CRIJ', NULL
	);	
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'CQNJ', 588, 'Queen Anne', 'Queen Anne', 
		'CW', 1, 24, 'CIDM-5447', now(), 'CIDM-5447', now(), 587, 'CRIJ', NULL
	);	
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'CSMJ', 588, 'Somerset', 'Somerset', 
		'CW', 1, 25, 'CIDM-5447', now(), 'CIDM-5447', now(), 587, 'CRIJ', NULL
	);	
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'CSTJ', 588, 'St. Mary''s', 'St. Mary''s', 
		'CW', 1, 26, 'CIDM-5447', now(), 'CIDM-5447', now(), 587, 'CRIJ', NULL
	);		
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'CTBJ', 588, 'Talbot', 'Talbot', 
		'CW', 1, 27, 'CIDM-5447', now(), 'CIDM-5447', now(), 587, 'CRIJ', NULL
	);	
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'CWCJ', 588, 'Washington', 'Washington', 
		'CW', 1, 28, 'CIDM-5447', now(), 'CIDM-5447', now(), 587, 'CRIJ', NULL
	);		
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'CWMJ', 588, 'Wicomico', 'Wicomico', 
		'CW', 1, 29, 'CIDM-5447', now(), 'CIDM-5447', now(), 587, 'CRIJ', NULL
	);	
	
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'CWRJ', 588, 'Worcester', 'Worcester', 
		'CW', 1, 30, 'CIDM-5447', now(), 'CIDM-5447', now(), 587, 'CRIJ', NULL
	);
-- Initial contact caregiver 3rd dropdown - End	
-- Initial contact caregiver - End