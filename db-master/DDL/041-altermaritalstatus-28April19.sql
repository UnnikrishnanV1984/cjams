alter table personmaritalstatus alter column insertedby TYPE character varying(50);

ALTER TABLE cjams.actor ADD personroletypeid uuid NULL;
ALTER TABLE cjams.actor ADD drugexposedkey varchar(50) NULL;
ALTER TABLE cjams.personroletype ADD isprimary varchar NULL;