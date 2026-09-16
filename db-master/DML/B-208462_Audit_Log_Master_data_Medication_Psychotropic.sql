----------------------------------------------------------------
-- 04/08/2025 - B-208462 (CIDM-10354) - Naveenkumar Chemutu
---------------------------------------------------------------


Delete from auditlogtype where modulename = 'Medication_Psychotropic' ;

INSERT INTO cjams.auditlogtype
	(	logtypeid, logtypekey, logtype, modulename, effectivedate, 
		expirationdate, insertedby, updatedby, insertedon, updatedon, old_id
	)
VALUES
	(	gen_random_uuid(), 'open-medication-psychotropic', 'User visited Medication-Psychotropic page.', 'Medication_Psychotropic', now(), 
		NULL, 'CIDM-10354', 'CIDM-10354', now(), now(), NULL
	);
	
INSERT INTO cjams.auditlogtype
	(	logtypeid, logtypekey, logtype, modulename, effectivedate, 
		expirationdate, insertedby, updatedby, insertedon, updatedon, old_id
	)
VALUES
	(	gen_random_uuid(), 'add-medication-psychotropic', 'User clicked on add new Medication-Psychotropic page', 'Medication_Psychotropic', now(), 
		NULL, 'CIDM-10354', 'CIDM-10354', now(), now(), NULL
	);
	
INSERT INTO cjams.auditlogtype
	(	logtypeid, logtypekey, logtype, modulename, effectivedate, 
		expirationdate, insertedby, updatedby, insertedon, updatedon, old_id
	)
VALUES
	(	gen_random_uuid(), 'edit-medication-psychotropic', 'User clicked on edit Medication-Psychotropic page', 'Medication_Psychotropic', now(), 
		NULL, 'CIDM-10354', 'CIDM-10354', now(), now(), NULL
	);
	
INSERT INTO cjams.auditlogtype
	(	logtypeid, logtypekey, logtype, modulename, effectivedate, 
		expirationdate, insertedby, updatedby, insertedon, updatedon, old_id
	)
VALUES
	(	gen_random_uuid(), 'view-medication-psychotropic', 'User viewed the Medication-Psychotropic page.', 'Medication_Psychotropic', now(), 
		NULL, 'CIDM-10354', 'CIDM-10354', now(), now(), NULL
	);

INSERT INTO cjams.auditlogtype
	(	logtypeid, logtypekey, logtype, modulename, effectivedate, 
		expirationdate, insertedby, updatedby, insertedon, updatedon, old_id
	)
VALUES
	(	gen_random_uuid(), 'delete-medication-psychotropic', 'User Deleted the Medication-Psychotropic page.', 'Medication_Psychotropic', now(), 
		NULL, 'CIDM-10354', 'CIDM-10354', now(), now(), NULL
	);
	
INSERT INTO cjams.auditlogtype
	(	logtypeid, logtypekey, logtype, modulename, effectivedate, 
		expirationdate, insertedby, updatedby, insertedon, updatedon, old_id
	)
VALUES
	(	gen_random_uuid(), 'leave-from-medication-psychotropic', 'User moved to another page from the Medication-Psychotropic page.', 'Medication_Psychotropic', now(), 
		NULL, 'CIDM-10354', 'CIDM-10354', now(), now(), NULL
	);


INSERT INTO cjams.auditlogtype
	(	logtypeid, logtypekey, logtype, modulename, effectivedate, 
		expirationdate, insertedby, updatedby, insertedon, updatedon, old_id
	)
VALUES
	(	gen_random_uuid(), 'yes-popup-medication-psychotropic', 'User selected Yes from Medication-Psychotropic popup.', 'Medication_Psychotropic', now(), 
		NULL, 'CIDM-10354', 'CIDM-10354', now(), now(), NULL
	);

INSERT INTO cjams.auditlogtype
	(	logtypeid, logtypekey, logtype, modulename, effectivedate, 
		expirationdate, insertedby, updatedby, insertedon, updatedon, old_id
	)
VALUES
	(	gen_random_uuid(), 'no-popup-medication-psychotropic', 'User selected No from Medication-Psychotropic popup.', 'Medication_Psychotropic', now(), 
		NULL, 'CIDM-10354', 'CIDM-10354', now(), now(), NULL
	);	


INSERT INTO cjams.auditlogtype
	(	logtypeid, logtypekey, logtype, modulename, effectivedate, 
		expirationdate, insertedby, updatedby, insertedon, updatedon, old_id
	)
VALUES
	(	gen_random_uuid(), 'close-medication-psychotropic', 'User closed the Medication-Psychotropic popup', 'Medication_Psychotropic', now(), 
		NULL, 'CIDM-10354', 'CIDM-10354', now(), now(), NULL
	);	