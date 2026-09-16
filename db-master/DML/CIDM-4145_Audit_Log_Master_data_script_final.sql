-- CIDM-4145 - Contact Notes Audit Log
/*
Capture Person Visit Date and Time when ever:

1) User Visit Contact Notes Page: 
Event Description - User visited contact notes page.
	
2) User Click ADD Contact: 
Event Description - User clicked on add new contact note.

3) User Click View Contact Note: 
Event Description - User viewed the contact note.
	
4) User Click some other menu from Contacts screen: 
Event Description - User moved to another page from the contact note page.

5) User Click Download Contact Notes: 
Event Description - User downloaded the contact note.

6) User Edit a Contact: 
Event Description - User clicked on edit contact note.

7) User Added an Addendum to a Contact By click on the Button ADDENDUM within the contact Screen:
Event Description - User clicked on add Addendum.
-- User updated the contact note with additional information (Addendum). ??
	
8) User Click "SAVE" Contact:
Event Description - User clicked on save contact note.
	
9) Contact Note Auto Save
Event Description - Contact note was Auto-saved.
	
10) User Click "SAVE" on Contact Addendum page:	
Event Description - User clicked on save addendum contact note.
	
11) Contact Note Close X button clicked
Event Description - User closed the contact note screen.

12) Contact Note Back button clicked
Event Description - User clicked on the Back button on contact note.

13) Contact Note Addendum Auto Save
Event Description - Addendum was auto-saved.
*/
	

INSERT INTO cjams.auditlogtype
	(	logtypeid, logtypekey, logtype, modulename, effectivedate, 
		expirationdate, insertedby, updatedby, insertedon, updatedon, old_id
	)
VALUES
	(	gen_random_uuid(), 'open-contact-note', 'User visited contact notes page.', 'Contacts', now(), 
		NULL, 'CIDM-4145', 'CIDM-4145', now(), now(), NULL
	);
	
INSERT INTO cjams.auditlogtype
	(	logtypeid, logtypekey, logtype, modulename, effectivedate, 
		expirationdate, insertedby, updatedby, insertedon, updatedon, old_id
	)
VALUES
	(	gen_random_uuid(), 'add-contact-note', 'User clicked on add new contact note.', 'Contacts', now(), 
		NULL, 'CIDM-4145', 'CIDM-4145', now(), now(), NULL
	);
	
INSERT INTO cjams.auditlogtype
	(	logtypeid, logtypekey, logtype, modulename, effectivedate, 
		expirationdate, insertedby, updatedby, insertedon, updatedon, old_id
	)
VALUES
	(	gen_random_uuid(), 'edit-contact-note', 'User clicked on edit contact note.', 'Contacts', now(), 
		NULL, 'CIDM-4145', 'CIDM-4145', now(), now(), NULL
	);
	
INSERT INTO cjams.auditlogtype
	(	logtypeid, logtypekey, logtype, modulename, effectivedate, 
		expirationdate, insertedby, updatedby, insertedon, updatedon, old_id
	)
VALUES
	(	gen_random_uuid(), 'view-contact-note', 'User viewed the contact note.', 'Contacts', now(), 
		NULL, 'CIDM-4145', 'CIDM-4145', now(), now(), NULL
	);
	
INSERT INTO cjams.auditlogtype
	(	logtypeid, logtypekey, logtype, modulename, effectivedate, 
		expirationdate, insertedby, updatedby, insertedon, updatedon, old_id
	)
VALUES
	(	gen_random_uuid(), 'leave-from-contact-note', 'User moved to another page from the contact note page.', 'Contacts', now(), 
		NULL, 'CIDM-4145', 'CIDM-4145', now(), now(), NULL
	);	

INSERT INTO cjams.auditlogtype
	(	logtypeid, logtypekey, logtype, modulename, effectivedate, 
		expirationdate, insertedby, updatedby, insertedon, updatedon, old_id
	)
VALUES
	(	gen_random_uuid(), 'download-contact-note', 'User downloaded the contact note.', 'Contacts', now(), 
		NULL, 'CIDM-4145', 'CIDM-4145', now(), now(), NULL
	);	

INSERT INTO cjams.auditlogtype
	(	logtypeid, logtypekey, logtype, modulename, effectivedate, 
		expirationdate, insertedby, updatedby, insertedon, updatedon, old_id
	)
VALUES
	(	gen_random_uuid(), 'add-note-addendum', 'User clicked on add Addendum.', 'Contacts', now(), 
		NULL, 'CIDM-4145', 'CIDM-4145', now(), now(), NULL
	);	

INSERT INTO cjams.auditlogtype
	(	logtypeid, logtypekey, logtype, modulename, effectivedate, 
		expirationdate, insertedby, updatedby, insertedon, updatedon, old_id
	)
VALUES
	(	gen_random_uuid(), 'save-contact-note', 'User clicked on save contact note.', 'Contacts', now(), 
		NULL, 'CIDM-4145', 'CIDM-4145', now(), now(), NULL
	);	

INSERT INTO cjams.auditlogtype
	(	logtypeid, logtypekey, logtype, modulename, effectivedate, 
		expirationdate, insertedby, updatedby, insertedon, updatedon, old_id
	)
VALUES
	(	gen_random_uuid(), 'autosave-contact-note', 'Contact note was auto-saved.', 'Contacts', now(), 
		NULL, 'CIDM-4145', 'CIDM-4145', now(), now(), NULL
	);	

INSERT INTO cjams.auditlogtype
	(	logtypeid, logtypekey, logtype, modulename, effectivedate, 
		expirationdate, insertedby, updatedby, insertedon, updatedon, old_id
	)
VALUES
	(	gen_random_uuid(), 'save-note-addendum', 'User clicked on save contact note addendum.', 'Contacts', now(), 
		NULL, 'CIDM-4145', 'CIDM-4145', now(), now(), NULL
	);	

INSERT INTO cjams.auditlogtype
	(	logtypeid, logtypekey, logtype, modulename, effectivedate, 
		expirationdate, insertedby, updatedby, insertedon, updatedon, old_id
	)
VALUES
	(	gen_random_uuid(), 'close-contact-note', 'User closed the contact note screen.', 'Contacts', now(), 
		NULL, 'CIDM-4145', 'CIDM-4145', now(), now(), NULL
	);	

INSERT INTO cjams.auditlogtype
	(	logtypeid, logtypekey, logtype, modulename, effectivedate, 
		expirationdate, insertedby, updatedby, insertedon, updatedon, old_id
	)
VALUES
	(	gen_random_uuid(), 'back-contact-note', 'User clicked on the Back button on contact note.', 'Contacts', now(), 
		NULL, 'CIDM-4145', 'CIDM-4145', now(), now(), NULL
	);	
	
/*
-- Addendum auto-save is not happening in CJAMS 

INSERT INTO cjams.auditlogtype
	(	logtypeid, logtypekey, logtype, modulename, effectivedate, 
		expirationdate, insertedby, updatedby, insertedon, updatedon, old_id
	)
VALUES
	(	gen_random_uuid(), 'autosave-addendum', 'Addendum was auto-saved..', 'Contacts', now(), 
		NULL, 'CIDM-4145', 'CIDM-4145', now(), now(), NULL
	);	
*/	

select logtypeid , logtypekey, logtype, insertedby, updatedby, updatedon  
	from auditlogtype 
where insertedby = 'CIDM-4145' ;	
	