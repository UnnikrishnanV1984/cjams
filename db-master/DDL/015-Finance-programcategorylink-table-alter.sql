alter table programcategorylink 
drop column if exists fiscalcategoryid ;

alter table programcategorylink 
add column if not exists fiscalcategoryid  integer;