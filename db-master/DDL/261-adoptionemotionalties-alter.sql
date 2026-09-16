ALTER TABLE adoptionemotionalties ALTER COLUMN insertedby TYPE varchar(50) ;

ALTER TABLE adoptionemotionalties ALTER COLUMN updatedby TYPE varchar(50) ;

ALTER TABLE adoptionemotionalties RENAME COLUMN adoptionid TO adoptionplanningid;

ALTER TABLE adoptionemotionalties ALTER COLUMN emotionaltieid SET DEFAULT gen_random_uuid();

alter table adoptionemotionalties add column if not exists providerid integer null;

