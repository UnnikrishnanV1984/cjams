create index Xie2_auditlog on auditlog(date(insertedon),lower(objecttype));
create index Xie3_auditlog on auditlog(insertedby,lower(objecttype));