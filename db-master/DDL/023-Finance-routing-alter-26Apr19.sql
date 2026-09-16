
alter table routingconfig 
add column if not exists principaltype character varying;

alter table routing
add column if not exists principaltype character varying;

alter table routing 
alter column tosecurityusersid  DROP NOT NULL;