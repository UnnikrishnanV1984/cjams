alter table publicproviderhomeinfo add column if not exists ownerorrenter varchar(50) null;
alter table publicproviderhomeinfo add column if not exists propertybuiltyear varchar(50) null;

alter table providerapprovetypeconfig add column if not exists isclosereopen boolean null;