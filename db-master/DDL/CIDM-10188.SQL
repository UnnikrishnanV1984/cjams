DROP TABLE if exists cjams.holidays;

CREATE TABLE if not exists cjams.holidays (
holidaysid uuid NOT NULL DEFAULT cjams.gen_random_uuid(),
date varchar(255)  NULL ,
year varchar(255)  NULL ,
month varchar(255)  NULL ,
description varchar(255)  NULL ,
activeflag int4 NOT NULL DEFAULT 1,
updatedby varchar(50) NULL,
updatedon timestamp NOT NULL DEFAULT now(),
insertedby varchar(50) NULL,
insertedon timestamp NOT NULL DEFAULT now(),
CONSTRAINT pk_holidaysid PRIMARY KEY (holidaysid)
);



COMMENT ON COLUMN cjams.holidays.holidaysid IS 'Unique identifier for the holiday (primary key).';
COMMENT ON COLUMN cjams.holidays.date IS 'Date of the holiday, stored as a string.';
COMMENT ON COLUMN cjams.holidays.year IS 'Year in which the holiday occurs.';
COMMENT ON COLUMN cjams.holidays.month IS 'Month of the holiday, stored as a string.';
COMMENT ON COLUMN cjams.holidays.description IS 'Description or name of the holiday.';
COMMENT ON COLUMN cjams.holidays.activeflag IS 'Indicates whether the holiday is active (1 for active, 0 for inactive).';
COMMENT ON COLUMN cjams.holidays.updatedby IS 'The user who last updated the holiday information.';
COMMENT ON COLUMN cjams.holidays.updatedon IS 'Timestamp of the last update to the holiday record.';
COMMENT ON COLUMN cjams.holidays.insertedby IS 'The user who initially inserted the holiday record.';
COMMENT ON COLUMN cjams.holidays.insertedon IS 'Timestamp of when the holiday record was first inserted.';