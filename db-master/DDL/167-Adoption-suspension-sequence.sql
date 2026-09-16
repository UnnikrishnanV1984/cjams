ALTER TABLE cjams.adoptionsuspension
    ADD column if not exists alternateid bigint;

DROP SEQUENCE  IF EXISTS sequence_adoptionsuspension CASCADE; 
CREATE SEQUENCE sequence_adoptionsuspension
    INCREMENT 1
    START 1000001
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER  TABLE adoptionsuspension ALTER COLUMN alternateid  SET DEFAULT nextval('sequence_adoptionsuspension'::regclass);
UPDATE adoptionsuspension SET alternateid =nextval('sequence_adoptionsuspension'::regclass) ;

 
ALTER TABLE cjams.adoptionsuspensionrevision
    ADD column if not exists alternateid bigint;

DROP SEQUENCE  IF EXISTS sequence_adoptionsuspensionrevision CASCADE; 
CREATE SEQUENCE sequence_adoptionsuspensionrevision
    INCREMENT 1
    START 1000001
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER  TABLE adoptionsuspensionrevision ALTER COLUMN alternateid  SET DEFAULT nextval('sequence_adoptionsuspensionrevision'::regclass);
UPDATE adoptionsuspensionrevision SET alternateid =nextval('sequence_adoptionsuspensionrevision'::regclass) ;