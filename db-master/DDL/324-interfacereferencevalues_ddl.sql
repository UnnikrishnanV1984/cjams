drop table if exists interfacereferencevalues;--
create table interfacereferencevalues(
valueid serial, 
cheesiecode varchar(50) null,
referencetype varchar(50) null, 
description varchar(100) null,
desctypekey varchar(50) null,
desclevel2typekey varchar(10) null
)
