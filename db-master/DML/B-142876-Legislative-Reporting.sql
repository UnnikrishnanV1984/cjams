delete from cjams.referencevalues where ref_key in('SDNRAA','DAEERR','FRARNP','ROAPNG','EMEPRE') and referencetypeid=5466;

delete from cjams.referencetype where referencetypeid=5466;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('SDNRAA', 5466, 'Supervisor did not review and approve case closure timely', 'Supervisor did not review and approve case closure timely', 'CW', 1, 1, 'CIDM-5519', now(), 'CIDM-5519', now(), NULL, NULL, NULL);


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('DAEERR', 5466, 'Data entry error', 'Data entry error', 'CW', 1, 2, 'CIDM-5519', now(), 'CIDM-5519', now(), NULL, NULL, NULL);


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('FRARNP', 5466, 'For a reason not provided by law or policy', 'For a reason not provided by law or policy', 'CW', 1, 3, 'CIDM-5519', now(), 'CIDM-5519', now(), NULL, NULL, NULL);


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('ROAPNG', 5466, 'ROA pending - Family is out of State', 'ROA pending - Family is out of State', 'CW', 1, 4, 'CIDM-5519', now(), 'CIDM-5519', now(), NULL, NULL, NULL);


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('EMEPRE', 5466, ' Emergency situation prevented timely case closure', ' Emergency situation prevented timely case closure', 'CW', 1, 5, 'CIDM-5519', now(), 'CIDM-5519', now(), NULL, NULL, NULL);





INSERT INTO cjams.referencetype
(referencetypeid, typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES(5466, 'Legislative Required Reporting', 'Legislative Required Reporting:', 1, 'CIDM-5519', now(), 'CIDM-5519', now(), NULL);


delete from cjams.referencevalues where ref_key in('FAMRCW','PENINV','PENMED','ATTCON') and referencetypeid=5467;

delete from cjams.referencetype where referencetypeid=5467;



INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('FAMRCW', 5467, 'Family refused to cooperate with the Department delaying case closure', ' Family refused to cooperate with the Department delaying case closure', 'CW', 1, 1, 'CIDM-5519', now(), 'CIDM-5519', now(), NULL, 'FRARNP', NULL);


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('PENINV', 5467, 'Pending criminal investigation - delays created by law enforcement', 'Pending criminal investigation - delays created by law enforcement', 'CW', 1, 2, 'CIDM-5519', now(), 'CIDM-5519', now(), NULL, 'FRARNP', NULL);



INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('PENMED', 5467, 'Pending medical information required to make a finding', 'Pending medical information required to make a finding', 'CW', 1, 3, 'CIDM-5519', now(), 'CIDM-5519', now(), NULL, 'FRARNP', NULL);




INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('ATTCON', 5467, 'Attempting to connect family to ongoing services/referrals', 'Attempting to connect family to ongoing services/referrals', 'CW', 1, 4, 'CIDM-5519', now(), 'CIDM-5519', now(), NULL, 'FRARNP', NULL);




INSERT INTO cjams.referencetype
(referencetypeid, typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES(5467, 'For a reason not provided by law or policy', 'For a reason not provided by law or policy', 1, 'CIDM-5519', now(), 'CIDM-5519', now(), NULL);



delete from cjams.referencevalues where ref_key in('NADIER','NOREEM') and referencetypeid=5468;

delete from cjams.referencetype where referencetypeid=5468;



INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('NADIER', 5468, 'Natural disaster', 'Natural disaster', 'CW', 1, 1, 'CIDM-5519', now(), 'CIDM-5519', now(), NULL, 'EMEPRE', NULL);



INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('NOREEM', 5468, 'Non-work related emergency', 'Non-work related emergency', 'CW', 1, 2, 'CIDM-5519', now(), 'CIDM-5519', now(), NULL, 'EMEPRE', NULL);



INSERT INTO cjams.referencetype
(referencetypeid, typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES(5468, 'Emergency situation prevented timely case closure', 'Emergency situation prevented timely case closure', 1, 'CIDM-5519', now(), 'CIDM-5519', now(), NULL);