DROP SEQUENCE  IF EXISTS sequence_cjamscisref CASCADE;
   CREATE SEQUENCE sequence_cjamscisref
   INCREMENT 1
   START 8000001
   MINVALUE 8000000
   MAXVALUE 9223372036854775807
   CACHE 1;

CREATE TABLE cjamscisref (
	cjamscisrefid uuid NOT NULL DEFAULT gen_random_uuid(),
	obectid varchar(14) null,
	cisrefid varchar(9) NULL DEFAULT nextval('sequence_cjamscisref'::regclass)
);
ALTER TABLE cjams.cjamscisref DROP COLUMN IF EXISTS obectid;

 

ALTER TABLE cjams.cjamscisref ADD COLUMN IF NOT EXISTS casenumber varchar(50) NULL;
ALTER TABLE cjams.cjamscisref ADD COLUMN IF NOT EXISTS objectid uuid NULL;
ALTER TABLE cjams.cjamscisref ADD COLUMN IF NOT EXISTS activeflag int4 NULL DEFAULT 1;
ALTER TABLE cjams.cjamscisref ADD COLUMN IF NOT EXISTS insertedby varchar(50) NULL;
ALTER TABLE cjams.cjamscisref ADD COLUMN IF NOT EXISTS insertedon timestamp NOT NULL DEFAULT now();
ALTER TABLE cjams.cjamscisref ADD COLUMN IF NOT EXISTS updatedby varchar(50) NULL;
ALTER TABLE cjams.cjamscisref ADD COLUMN IF NOT EXISTS updatedon timestamp NULL;

   
   