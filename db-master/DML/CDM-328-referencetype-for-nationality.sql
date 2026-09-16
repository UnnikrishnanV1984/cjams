INSERT INTO cjams.referencetype
(referencetypeid, typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES(304, 'Nationality', 'nationality', 1, 'admin', now(), 'admin',now(), NULL);

update cjams.referencevalues set referencetypeid = 304, activeflag = 1 where referencetypeid = 300 and activeflag = 0 and ref_key not in ('99','88','A','D');


