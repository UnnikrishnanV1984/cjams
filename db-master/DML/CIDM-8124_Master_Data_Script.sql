-- CIDM-8124 - CJAMS Interfaces Status Monitoring Batch job modifications

-- Master Data Interfaces Status Monitoring

-- Revision(s)
-- 11/16/2023 - To add new value Summary

-- Delete 
Delete from referencetype where referencetypeid = 591 and insertedby = 'CIDM-8124' ;

Delete from referencevalues where referencetypeid = 591 and insertedby = 'CIDM-8124' ;

-- CJAMS Interfaces Status Monitoring
INSERT INTO cjams.referencetype
	(	referencetypeid, typedescription, tablename, 
		activeflag, insertedby, insertedon, updatedby, updatedon, flag
	)
VALUES
	(	591, 'CJAMS Interfaces Status Monitoring', 'interfacesmonitoring', 
		1, 'CIDM-8124', now(), 'CIDM-8124', now(), NULL 
	);

-- A. CJAMS has sent the new referral requests successfully for <??> clients to CSMS.
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, 
		description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'NSCSMS', 591, 'CJAMS has sent the new referral requests successfully for <??> clients to CSMS.', 
		'CJAMS has sent the new referral requests successfully for <??> clients to CSMS.', 
		'CW', 1, 1, 'CIDM-8124', now(), 'CIDM-8124', now(), NULL, NULL, NULL
	);

-- B. <??> CJAMS''s new referral requests failed to interface with CSMS.
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, 
		description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'NFCSMS', 591, '<??> CJAMS''s new referral requests failed to interface with CSMS.', 
		'<??> CJAMS''s new referral requests failed to interface with CSMS.', 
		'CW', 1, 2, 'CIDM-8124', now(), 'CIDM-8124', now(), NULL, NULL, NULL
	);
	
	
-- C. CJAMS has sent the Updated referral requests successfully for <??> clients to CSMS.
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, 
		description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'USCSMS', 591, 'CJAMS has sent the Updated referral requests successfully for <??> clients to CSMS.', 
		'CJAMS has sent the Updated referral requests successfully for <??> clients to CSMS.', 
		'CW', 1, 3, 'CIDM-8124', now(), 'CIDM-8124', now(), NULL, NULL, NULL
	);


-- D. <??> CJAMS''s updated referral requests failed to interface with CSMS.
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, 
		description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'UFCSMS', 591, '<??> CJAMS''s updated referral requests failed to interface with CSMS.', 
		'<??> CJAMS''s updated referral requests failed to interface with CSMS.', 
		'CW', 1, 4, 'CIDM-8124', now(), 'CIDM-8124', now(), NULL, NULL, NULL
	);
	
-- E. CJAMS Outbound Batch # <?>, CJAMS has sent the data for <??> clients to E&E.
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, 
		description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'OBENE', 591, 'CJAMS Outbound Batch # <?>, CJAMS has sent the data for <??> clients to E&E.', 
		'CJAMS Outbound Batch # <?>, CJAMS has sent the data for <??> clients to E&E.', 
		'CW', 1, 5, 'CIDM-8124', now(), 'CIDM-8124', now(), NULL, NULL, NULL
	);
	
-- F. E&E Interim Batch # <?>, E&E has sent the data for <??> clients to CJAMS.
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, 
		description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'IBENE', 591, 'E&E Interim Batch # <?>, E&E has sent the data for <??> clients to CJAMS.', 
		'E&E Interim Batch # <?>, E&E has sent the data for <??> clients to CJAMS.', 
		'CW', 1, 6, 'CIDM-8124', now(), 'CIDM-8124', now(), NULL, NULL, NULL
	);
	
-- G. 
-- E&E has sent the success response for CJAMS Outbound Batch # <?>
-- OR
-- CJAMS Outbound Batch # <?> was rejected by the E&E.
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, 
		description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'OBRENE', 591, '<??>', 
		'E&E has sent the success response or Rejection for CJAMS Outbound Batch # <?>', 
		'CW', 1, 7, 'CIDM-8124', now(), 'CIDM-8124', now(), NULL, NULL, NULL
	);
	
-- H. CJAMS has sent the data for <??> Out-of-Home clients to Citizens Review Board for Children (CRBC).
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, 
		description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'OBCRB', 591, 'CJAMS has sent the data for <??> Out-of-Home clients to Citizens Review Board for Children (CRBC).', 
		'CJAMS has sent the data for <??> Out-of-Home clients to Citizens Review Board for Children (CRBC).', 
		'CW', 1, 8, 'CIDM-8124', now(), 'CIDM-8124', now(), NULL, NULL, NULL
	);

-- I. Summary
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, 
		description, 
		teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'INTSUM', 591, 'Summary of Interfaces Status Monitoring', 
		'Summary of Interfaces Status Monitoring', 
		'CW', 1, 9, 'CIDM-8124', now(), 'CIDM-8124', now(), NULL, NULL, NULL
	);


