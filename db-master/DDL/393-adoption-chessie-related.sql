ALTER TABLE cjams.adoptionlink ALTER COLUMN adoptionlinkid SET DEFAULT gen_random_uuid();
ALTER TABLE cjams.adoptionlink ALTER COLUMN insertedby TYPE varchar(50) USING insertedby::varchar;
ALTER TABLE cjams.adoptionlink ALTER COLUMN updatedby TYPE varchar(50) USING updatedby::varchar;
ALTER TABLE cjams.adoptionlink ALTER COLUMN clientmergeid DROP NOT NULL;
ALTER TABLE cjams.biologicaladoptionlink ALTER COLUMN biologicaladoptionlinkid SET DEFAULT gen_random_uuid();


ALTER TABLE cjams.chessierequestlog ADD COLUMN IF NOT EXISTS response jsonb NULL;
ALTER TABLE cjams.chessierequestlog ADD COLUMN IF NOT EXISTS activeflag int4 NOT NULL DEFAULT 1;
ALTER TABLE cjams.chessierequestlog ADD COLUMN IF NOT EXISTS insertedon timestamp NOT NULL DEFAULT now();
ALTER TABLE cjams.chessierequestlog ADD COLUMN IF NOT EXISTS insertedby varchar(50) NULL;
ALTER TABLE cjams.chessierequestlog ADD COLUMN IF NOT EXISTS updatedon timestamp NOT NULL DEFAULT now();
ALTER TABLE cjams.chessierequestlog ADD COLUMN IF NOT EXISTS updatedby varchar(50) NULL;