insert into referencetype (referencetypeid, typedescription, tablename, activeflag, insertedby, insertedon, updatedby,updatedon)
values (348, 'haircolor', 'haircolor', 1, 'admin',now(),'admin',now());

update referencevalues set referencetypeid = 348, teamtypekey = 'CW' where referencetypeid = '316' and teamtypekey is null;