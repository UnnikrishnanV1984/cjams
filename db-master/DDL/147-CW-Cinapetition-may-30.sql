alter table cinapetition 
alter column timeofremoval type character varying(50);

alter table cinasibling
add column if not exists narrative text;

alter table cinapetition
add column if not exists iskinhome boolean;