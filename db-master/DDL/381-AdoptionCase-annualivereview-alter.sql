ALTER TABLE adoptioniverenewal ALTER COLUMN adoptioniverenewalid SET DEFAULT gen_random_uuid();

alter table adoptioniverenewal alter column staffid  DROP NOT NULL;

ALTER TABLE adoptioniverenewal ALTER COLUMN insertedby TYPE varchar(50) ;

ALTER TABLE adoptioniverenewal ALTER COLUMN updatedby TYPE varchar(50) ;

alter table adoptioniverenewal add column if not exists effectivedate timestamp NOT NULL DEFAULT now() ;

alter table adoptioniverenewal add column if not exists ischilddisability int4 NULL;

alter table adoptioniverenewal add column if not exists ischildspecialneed int4 NULL;

alter table adoptioniverenewal add column if not exists isparentlegalresponsible int4 NULL;

alter table adoptioniverenewal add column if not exists isrenewalsigned int4 NULL;