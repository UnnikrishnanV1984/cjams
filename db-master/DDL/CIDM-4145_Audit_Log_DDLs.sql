-- CIDM-4145 - Contact Notes Audit Log DDLs

-- To alter the type of logtypekey column of cjams.auditlogtype & cjams.auditlog tables 
-- from varchar(10) to varchar(50)

-- Alter Column
alter table cjams.auditlogtype alter column logtypekey type varchar(50) ;

alter table cjams.auditlog alter column logtypekey type varchar(50) ;

