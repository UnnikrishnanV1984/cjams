alter table personmaritalstatus alter clientmergeid drop not null;
alter table personmaritalstatus alter column fk_id drop not null;
alter table personmaritalstatus alter column updatedby TYPE character varying(50);