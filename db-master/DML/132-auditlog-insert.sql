delete from  auditlogtype where logtypekey='WL004' AND logtype='Face to Face' AND
 modulename = 'Face to Face Contact made';

insert into auditlogtype (logtypekey, logtype, modulename, insertedby, updatedby)
values ('WL004','Face to Face', 'Face to Face Contact made', 'admin', 'admin');
 