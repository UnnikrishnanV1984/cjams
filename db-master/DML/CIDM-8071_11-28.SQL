--informed Consent
delete from cjams.referencetype where referencetypeid = 500121;

INSERT INTO cjams.referencetype
( referencetypeid,typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES( 500121,'informedconsent', 'informedconsent', 1, 'CIDM-8071', now(), 'CIDM-8071', now(), NULL);

delete from cjams.referencevalues where referencetypeid = 500121;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('LDP', 500121, 'LDSS provided informed consent', 'LDSS provided informed consent', 'CW', 1, 1, 'CIDM-8071', now(), 'CIDM-8071', now(), NULL, NULL, NULL),
('LDD', 500121, 'LDSS denied informed consent', 'LDSS denied informed consent', 'CW', 1, 1, 'CIDM-8071', now(), 'CIDM-8071', now(), NULL, NULL, NULL),
('CPI', 500121, 'Court provided informed consent', 'Court provided informed consent', 'CW', 1, 1, 'CIDM-8071', now(), 'CIDM-8071', now(), NULL, NULL, NULL),
('BPP', 500121, 'Parent or legal guardian provided informed consent', 'Parent or legal guardian provided informed consent', 'CW', 1, 1, 'CIDM-8071', now(), 'CIDM-8071', now(), NULL, NULL, NULL),
('BPD', 500121, 'Parent or legal guardian denied informed consent', 'Parent or legal guardian denied informed consent', 'CW', 1, 1, 'CIDM-8071', now(), 'CIDM-8071', now(), NULL, NULL, NULL),
('YAU', 500121, 'Youth assented', 'Youth assented', 'CW', 1, 1, 'CIDM-8071', now(), 'CIDM-8071', now(), NULL, NULL, NULL),
('YRS', 500121, 'Youth refused to sign', 'Youth refused to sign', 'CW', 1, 1, 'CIDM-8071', now(), 'CIDM-8071', now(), NULL, NULL, NULL),
('YPC', 500121, 'Youth provided informed consent - 16 and older', 'Youth provided informed consent - 16 and older', 'CW', 1, 1, 'CIDM-8071', now(), 'CIDM-8071', now(), NULL, NULL, NULL),
('YRC', 500121, 'Youth denied informed to consent - 16 and older', 'Youth denied informed to consent - 16 and older', 'CW', 1, 1, 'CIDM-8071', now(), 'CIDM-8071', now(), NULL, NULL, NULL);