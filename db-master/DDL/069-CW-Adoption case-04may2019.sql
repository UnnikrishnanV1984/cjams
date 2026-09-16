ALTER TABLE cjams.adoptionagreement ADD COLUMN IF NOT EXISTS parent1providerid int4 NULL;
ALTER TABLE cjams.adoptionagreement ADD COLUMN IF NOT EXISTS parent2providerid int4 NULL;
ALTER TABLE cjams.adoptionagreement ADD COLUMN IF NOT EXISTS parent1providername varchar(100) NULL;
ALTER TABLE cjams.adoptionagreement ADD COLUMN IF NOT EXISTS parent2providername varchar(100) NULL;