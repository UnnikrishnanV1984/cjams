update progressnotetype set progressnotetypekey = 'FaceToFace' where progressnotetypekey = 'Face to Face';
update progressnotetype set progressnotetypekey = 'E-mail' where progressnotetypekey = 'Email';
INSERT INTO progressnotetype (progressnotetypeid, progressnotetypekey, activeflag, description, insertedby, insertedon, effectivedate, progressnoteclassificationtypekey) 
VALUES (uuid_generate_v1(), 'Portal', 1, 'Portal', 'migration user', now(), now(),'user');
INSERT INTO progressnotetype (progressnotetypeid, progressnotetypekey, activeflag, description, insertedby, insertedon, effectivedate, progressnoteclassificationtypekey) 
VALUES (uuid_generate_v1(), 'Court Document/Process Server', 1, 'Court Document/Process Server', 'migration user', now(), now(),'user');
alter table legalcustody alter column addresstypekey type character varying(32);
alter table legalcustody alter column unitno type character varying(32);
alter table legalcustody alter column unittypekey type character varying(32);
alter table legalcustody alter column predirtypekey type character varying(32);
alter table legalcustody alter column statetypekey type character varying(32);
alter table legalcustody alter column streetsuffixtypekey type character varying(32);
alter table legalcustody alter column formattypekey type character varying(32);
alter table legalcustody alter column postdirtypekey type character varying(32);
alter table serviceplan alter column serviceplanname type character varying(2000);
alter table personeducation alter column disciplinaryactioncomments type character varying(2000);
alter table personeducation alter column transportmodetypedetail type character varying(2000);
