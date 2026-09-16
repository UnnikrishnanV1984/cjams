DELETE from referencevalues where ref_key = 'CPSRTS' and referencetypeid = 46;

INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, 
	description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon)
VALUES(	'CPSRTS', 46, 'CPS Response Timer Skip Request to Supervisor', 
		'CPS Response Timer Skip Request to Supervisor', NULL, 1, 1, 'CIDM-5447', now(), 'CIDM-5447', now());

DELETE from referencevalues where ref_key = 'CPSRTSV' and referencetypeid = 46;

INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text,
	description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon)
VALUES( 'CPSRTSV', 46, 'CPS Response Timer Save Request to Supervisor', 
		'CPS Response Timer Save Request to Supervisor', NULL, 1, 1, 'CIDM-5447', now(), 'CIDM-5447', now());

