
alter table IF EXISTS cjams.livingarrangement 
add column IF NOT EXISTS whereabouts varchar(10),
add column IF NOT EXISTS tribalservicearea varchar(10);