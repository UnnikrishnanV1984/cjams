
DROP SEQUENCE  IF EXISTS sequence_gapsuspensionrevision CASCADE; 
CREATE SEQUENCE sequence_gapsuspensionrevision
    INCREMENT 1
    START 1000001
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
ALTER  TABLE gapsuspensionrevision ADD column if not exists alternateid bigint; 
ALTER  TABLE gapsuspensionrevision ALTER COLUMN alternateid  SET DEFAULT nextval('sequence_gapsuspensionrevision'::regclass);
UPDATE gapsuspensionrevision SET alternateid =nextval('sequence_gapsuspensionrevision'::regclass) ;

DROP SEQUENCE  IF EXISTS sequence_gapsuspension CASCADE; 
CREATE SEQUENCE sequence_gapsuspension
    INCREMENT 1
    START 1000001
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
ALTER  TABLE gapsuspension ADD column if not exists alternateid bigint; 
ALTER  TABLE gapsuspension ALTER COLUMN alternateid  SET DEFAULT nextval('sequence_gapsuspension'::regclass);
UPDATE gapsuspension SET alternateid =nextval('sequence_gapsuspension'::regclass) ;


ALTER TABLE cjams.gapsuspensionrevision ALTER COLUMN gapsuspensionrevisionid SET NOT NULL;
ALTER TABLE cjams.gapsuspensionrevision ALTER COLUMN gapsuspensionrevisionid SET DEFAULT gen_random_uuid();
