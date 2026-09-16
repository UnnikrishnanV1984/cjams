-- B-128967 - Transfer a Referral to Another Jurisdiction (CIDM-4372)


-- Transfer a Referral Su[ervisory Approval Event Code - referencetypeid: 46 (Routing Config)
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, teamtypekey, 
		activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, 
		parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'INTTRF', 46, 'Intake Transfer Review', 'Intake Transfer Review', 'CW', 
		1, NULL, 'CIDM-4372', now(), 'CIDM-4372', now(), 
		NULL, NULL, NULL
	);