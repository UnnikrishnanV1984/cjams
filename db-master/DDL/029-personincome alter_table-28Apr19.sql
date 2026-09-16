alter table personincome alter actorid drop not null;
alter table personincome alter clientmergeid drop not null;
alter table personincome add column personid uuid not null;
ALTER TABLE personincome ALTER COLUMN insertedby TYPE character varying;
ALTER TABLE personincome ALTER COLUMN updatedby TYPE character varying;