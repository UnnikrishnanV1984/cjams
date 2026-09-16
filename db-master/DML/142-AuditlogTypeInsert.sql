delete from auditlogtype where logtypekey in ('WL002','WL018','WL001');

insert into auditlogtype (logtypekey, logtype, modulename, insertedby, updatedby,insertedon, updatedon)
values ('WL002', 'Restricted case', 'Accessed Restricted case', 'admin', 'admin', now(), now());


insert into auditlogtype (logtypekey, logtype, modulename, insertedby, updatedby,insertedon, updatedon)
values ('WL018','Contact Notes', 'Addendum added to Contact', 'admin', 'admin', now(),now());

insert into auditlogtype (logtypekey, logtype, modulename, insertedby, updatedby,insertedon, updatedon)
values ('WL001','Assign Service Case', 'A program assigment is made', 'admin', 'admin', now(), now());