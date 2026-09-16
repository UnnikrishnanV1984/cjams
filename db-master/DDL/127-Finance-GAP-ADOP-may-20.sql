alter table gapratesrevision 
drop column if exists gaprateid;

alter table gapratesrevision 
add column if not exists gaprateid  uuid;

alter table gapratesrevision 
drop column if exists guardiansubsidyid;

alter table gapratesrevision 
add column if not exists guardiansubsidyid  uuid;

alter table gapratesrevision 
alter column transactiondate set default now()::date;

alter table gapratesrevision 
drop column if exists providerid;

alter table gapratesrevision 
add column if not exists providerid  integer;

alter table adoptionrevision 
drop column if exists providerid;

alter table adoptionrevision 
add column if not exists providerid  integer;

alter table tb_PAYMENT_RUNTIMES_LOG 
alter column payment_current_run_ts type character varying (50);

alter table tb_PAYMENT_RUNTIMES_LOG 
alter column  payment_previous_run_ts type character varying (50);

DROP SEQUENCE  IF EXISTS sequence_gapraterevision CASCADE; 
CREATE SEQUENCE sequence_gapraterevision
    INCREMENT 1
    START 1000001
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
ALTER  TABLE gapratesrevision ADD column if not exists alternateid bigint; 
ALTER  TABLE gapratesrevision ALTER COLUMN alternateid  SET DEFAULT nextval('sequence_gapraterevision'::regclass);
UPDATE gapratesrevision SET alternateid =nextval('sequence_gapraterevision'::regclass) ;

DROP SEQUENCE  IF EXISTS sequence_adoptionrevision CASCADE; 
CREATE SEQUENCE sequence_adoptionrevision
    INCREMENT 1
    START 1000001
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
ALTER  TABLE adoptionrevision ADD column if not exists alternateid bigint; 
ALTER  TABLE adoptionrevision ALTER COLUMN alternateid  SET DEFAULT nextval('sequence_adoptionrevision'::regclass);
UPDATE adoptionrevision SET alternateid =nextval('sequence_adoptionrevision'::regclass) ;