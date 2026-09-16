alter table adoptioncaserevision add column if not exists agreementrateid uuid null;


DROP SEQUENCE  IF EXISTS sequence_adoptioncaserevision ; 
CREATE SEQUENCE sequence_adoptioncaserevision
    INCREMENT 1
    START 1000001
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER  TABLE adoptioncaserevision ALTER COLUMN alternateid  SET DEFAULT nextval('sequence_adoptioncaserevision'::regclass);
UPDATE adoptioncaserevision SET alternateid =nextval('sequence_adoptioncaserevision'::regclass) ;


