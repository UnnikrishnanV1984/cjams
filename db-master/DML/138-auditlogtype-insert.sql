delete from  auditlogtype where logtypekey='IN002' AND logtype='Maltreatment Allegation' AND
modulename = 'Investigation Started';

delete from  auditlogtype where logtypekey='RF001' AND logtype='Intake Submit' AND
modulename = 'Referral Received';

 
insert into auditlogtype (logtypekey, logtype, modulename, insertedby, updatedby)
values ('IN002','Maltreatment Allegation', 'Investigation Started', 'admin', 'admin');

insert into auditlogtype (logtypekey, logtype, modulename, insertedby, updatedby)
values ('RF001','Intake Submit', 'Referral Received', 'admin', 'admin');