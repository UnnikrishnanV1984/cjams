alter table personeducation
add column adresscounty varchar(250) null,
add column disciplinaryactioncomments varchar(250) null,
add column speacialeducationrestrictivekey varchar(15) null,
add column currentgradelevel varchar(15) NULL,
add column functioninggradelevel varchar(15) NULL,
add column lastgradelevel varchar(15) NULL,
add column highestgradetypekey varchar(15) null,
add column summerschoolname varchar(200) NULL,
add column firstqtrabsenceexcused int4 null,
add column firstqtrabsencenotexcused int4 null,
add column firstqtrabsencetardy int4 null,
add column firstqtrabsence int4 null,
add column secondqtrabsenceexcused int4 null,
add column secondqtrabsencenotexcused int4 null,
add column secondqtrabsencetardy int4 null,
add column secondqtrabsence int4 null,
add column thirdqtrabsenceexcused int4 null,
add column thirdqtrabsencenotexcused int4 null,
add column thirdqtrabsencetardy int4 null,
add column thirdqtrabsence int4 null,
add column fourthqtrabsenceexcused int4 null,
add column fourthqtrabsencenotexcused int4 null,
add column fourthqtrabsencetardy int4 null,
add column fourthqtrabsence int4 null,
add column numberofabsences int4 null,
add column lastifspdate timestamp NULL,
add column ifsplastdate timestamp NULL,
add column transportmodetypedetail varchar(250) null
;

alter table personeducation drop constraint fk_personeducation_county;
alter table personeducation drop constraint fk_personeducation_currentgradetype;
alter table personeducation drop constraint fk_personeducation_educationtype;
alter table personeducation drop constraint fk_personeducation_lastgradetype;
alter table personeducation drop constraint fk_personeducation_specialeducationtype;

alter table personspouseaddress
add column adr2 varchar(500) NULL,
add column adr1 varchar(500) NULL;

alter table person
add column preadoptiondate timestamp NULL,
add column aname bool NULL;
alter table person drop constraint fk_person_ethnicgrouptype;
alter table person drop constraint fk_person_gendertype;
alter table person drop constraint fk_person_maritalstatustype;
alter table person drop constraint fk_person_religiontype;


ALTER TABLE cjams.personmilitaryservices ALTER COLUMN personmilitaryserviceid SET NOT NULL;
ALTER TABLE cjams.personmilitaryservices ALTER COLUMN clientmergeid DROP NOT NULL;
ALTER TABLE cjams.personmilitaryservices ALTER COLUMN personid SET NOT NULL;
ALTER TABLE cjams.personmilitaryservices ALTER COLUMN serviceid DROP NOT NULL;