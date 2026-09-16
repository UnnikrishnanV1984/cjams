DELETE FROM referencetype WHERE referencetypeid = 751;

INSERT INTO referencetype(referencetypeid, typedescription,tablename, activeflag, insertedby, insertedon, updatedby, updatedon)
    VALUES (751, 'Case Type','Casetype',1,'Admin',now(), 'Admin', now());

DELETE FROM referencevalues WHERE referencetypeid = 751;

INSERT INTO referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon)
VALUES ('1',751, 'servicecase', 'Service Case', 'CW', 1, 1,'Admin',now(), 'Admin', now()),
	       ('2',751, 'IR', 'CPS-IR', 'CW', 1, 2,'Admin',now(), 'Admin', now()),
	       ('3',751, 'AR', 'CPS-AR', 'CW', 1, 2,'Admin',now(), 'Admin', now()),
	       ('4',751, 'noncps', 'Non-CPS', 'CW', 1, 2,'Admin',now(), 'Admin', now()),
	       ('5',751, 'intake', 'Intake', 'CW', 1, 2,'Admin',now(), 'Admin', now());
           