ALTER TABLE cjams.personprogramarea
    ADD COLUMN alternateid bigint;

DROP SEQUENCE  IF EXISTS sequence_personprogramarea CASCADE; 
CREATE SEQUENCE sequence_personprogramarea
    INCREMENT 1
    START 1000001
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER  TABLE personprogramarea ALTER COLUMN alternateid  SET DEFAULT nextval('sequence_personprogramarea'::regclass);
UPDATE personprogramarea SET alternateid =nextval('sequence_personprogramarea'::regclass) ;
 
 