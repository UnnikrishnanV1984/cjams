--multiple record remove record

--3148180
UPDATE intakeservreqchildremoval SET activeflag = 0, updatedby = 'CDM-7273', updatedon = now() WHERE
intakeservreqchildremovalid IN ('b4857490-a7a9-4984-b847-9d823fa5936f');

-- 3078093
UPDATE intakeservreqchildremoval SET activeflag = 0, updatedby = 'CDM-7273', updatedon = now() WHERE
intakeservreqchildremovalid IN ('7557c0f1-fc4f-42b3-bca6-4155eb0340b1') ;

UPDATE intakeservreqchildremoval SET updatedby = 'CDM-7273', updatedon = now(), agencytypekey = 'AFH',
COMMENTS = 'At court on 7/72020 the court closed the CINA case successfully ending the lengthy trial home visit of Tyrone and his mother, Donita Hall. Initially the Dept intended to keep the case open to provide services due to pandemic, but Ms. Hall and Tyrone requested case closure. they have been doing well'
WHERE intakeservreqchildremovalid IN ('746ea18d-bce4-4100-ae58-7741d5a0cf10') ;

--3303206
UPDATE intakeservreqchildremoval SET activeflag = 0, updatedby = 'CDM-7273', updatedon = now() WHERE
intakeservreqchildremovalid IN ('0a194085-e3a4-4e67-a91f-cc3244f1bac7');

UPDATE intakeservreqchildremoval SET parent2comments = 'the dad was out of town on business at the time', 
parentssigntypekey= 3001, childremovedfromtypekey='Legal Parent', rmvdfrmpersonname= 'Legal Parent',
fathername = 'DENISE MAINVILLE', intakeserviceid = '0c80caf0-9b9f-48cf-a188-4515254d9c48' 
WHERE intakeservreqchildremovalid = '5e4cf945-6889-482e-b068-a16d5a507e59';

-- Child removal end date and exit reason

UPDATE intakeservreqchildremoval r SET  updatedby='CDM-7273', updatedon=now(), exitdate='2020-10-07 00:00:00', removalexitreason='REUNIF' FROM person p, servicecase sc WHERE r.personid = p.personid AND sc.servicecaseid = r.servicecaseid AND sc.servicecasenumber = '3294349' AND p.cjamspid = '4319635' AND trunc(r.removaldate) = '2019-07-03' AND r.activeflag = 1 and exitdate is null ;
UPDATE intakeservreqchildremoval r SET  updatedby='CDM-7273', updatedon=now(), exitdate='2020-06-09 00:00:00', removalexitreason='CGUARDREL' FROM person p, servicecase sc WHERE r.personid = p.personid AND sc.servicecaseid = r.servicecaseid AND sc.servicecasenumber = '3290769' AND p.cjamspid = '4298248' AND trunc(r.removaldate) = '2018-11-07' AND r.activeflag = 1 and exitdate is null ;
UPDATE intakeservreqchildremoval r SET  updatedby='CDM-7273', updatedon=now(), exitdate='2020-08-11 00:00:00', removalexitreason='REUNIF' FROM person p, servicecase sc WHERE r.personid = p.personid AND sc.servicecaseid = r.servicecaseid AND sc.servicecasenumber = '3271176' AND p.cjamspid = '2401407' AND trunc(r.removaldate) = '2018-06-01' AND r.activeflag = 1 and exitdate is null ;
UPDATE intakeservreqchildremoval r SET  updatedby='CDM-7273', updatedon=now(), exitdate='2020-05-14 00:00:00', removalexitreason='CHREUNIFWF' FROM person p, servicecase sc WHERE r.personid = p.personid AND sc.servicecaseid = r.servicecaseid AND sc.servicecasenumber = '3276808' AND p.cjamspid = '4095387' AND trunc(r.removaldate) = '2017-09-06' AND r.activeflag = 1 and exitdate is null ;
UPDATE intakeservreqchildremoval r SET  updatedby='CDM-7273', updatedon=now(), exitdate='2020-05-14 00:00:00', removalexitreason='CHREUNIFWF' FROM person p, servicecase sc WHERE r.personid = p.personid AND sc.servicecaseid = r.servicecaseid AND sc.servicecasenumber = '3276808' AND p.cjamspid = '4095381' AND trunc(r.removaldate) = '2017-09-06' AND r.activeflag = 1 and exitdate is null ;
UPDATE intakeservreqchildremoval r SET  updatedby='CDM-7273', updatedon=now(), exitdate='2020-07-02 00:00:00', removalexitreason='REUNIF' FROM person p, servicecase sc WHERE r.personid = p.personid AND sc.servicecaseid = r.servicecaseid AND sc.servicecasenumber = '3267974' AND p.cjamspid = '4178010' AND trunc(r.removaldate) = '2018-01-16' AND r.activeflag = 1 and exitdate is null ;
UPDATE intakeservreqchildremoval r SET  updatedby='CDM-7273', updatedon=now(), exitdate='2020-08-18 00:00:00', removalexitreason='EMANIND' FROM person p, servicecase sc WHERE r.personid = p.personid AND sc.servicecaseid = r.servicecaseid AND sc.servicecasenumber = '3239872' AND p.cjamspid = '1405735' AND trunc(r.removaldate) = '2014-05-27' AND r.activeflag = 1 and exitdate is null ;
UPDATE intakeservreqchildremoval r SET  updatedby='CDM-7273', updatedon=now(), exitdate='2020-06-09 00:00:00', removalexitreason='CGUARDREL' FROM person p, servicecase sc WHERE r.personid = p.personid AND sc.servicecaseid = r.servicecaseid AND sc.servicecasenumber = '3290769' AND p.cjamspid = '4298250' AND trunc(r.removaldate) = '2018-11-07' AND r.activeflag = 1 and exitdate is null ;
UPDATE intakeservreqchildremoval r SET  updatedby='CDM-7273', updatedon=now(), exitdate='2020-09-09 00:00:00', removalexitreason='CHREUNIFWF' FROM person p, servicecase sc WHERE r.personid = p.personid AND sc.servicecaseid = r.servicecaseid AND sc.servicecasenumber = '3162484' AND p.cjamspid = '2493253' AND trunc(r.removaldate) = '2019-03-26' AND r.activeflag = 1 and exitdate is null ;
UPDATE intakeservreqchildremoval r SET  updatedby='CDM-7273', updatedon=now(), exitdate='2020-09-09 00:00:00', removalexitreason='CHREUNIFWF' FROM person p, servicecase sc WHERE r.personid = p.personid AND sc.servicecaseid = r.servicecaseid AND sc.servicecasenumber = '3162484' AND p.cjamspid = '2270379' AND trunc(r.removaldate) = '2019-03-26' AND r.activeflag = 1 and exitdate is null ;
UPDATE intakeservreqchildremoval r SET  updatedby='CDM-7273', updatedon=now(), exitdate='2020-05-19 00:00:00', removalexitreason='REUNIF' FROM person p, servicecase sc WHERE r.personid = p.personid AND sc.servicecaseid = r.servicecaseid AND sc.servicecasenumber = '3277289' AND p.cjamspid = '4094859' AND trunc(r.removaldate) = '2018-09-14' AND r.activeflag = 1 and exitdate is null ;
UPDATE intakeservreqchildremoval r SET  updatedby='CDM-7273', updatedon=now(), exitdate='2020-08-13 00:00:00', removalexitreason='EMANIND' FROM person p, servicecase sc WHERE r.personid = p.personid AND sc.servicecaseid = r.servicecaseid AND sc.servicecasenumber = '3253310' AND p.cjamspid = '3747589' AND trunc(r.removaldate) = '2015-05-01' AND r.activeflag = 1 and exitdate is null ;
UPDATE intakeservreqchildremoval r SET  updatedby='CDM-7273', updatedon=now(), exitdate='2020-09-22 00:00:00', removalexitreason='REUNIF' FROM person p, servicecase sc WHERE r.personid = p.personid AND sc.servicecaseid = r.servicecaseid AND sc.servicecasenumber = '3271433' AND p.cjamspid = '4107483' AND trunc(r.removaldate) = '2017-06-16' AND r.activeflag = 1 and exitdate is null ;
UPDATE intakeservreqchildremoval r SET  updatedby='CDM-7273', updatedon=now(), exitdate='2020-09-02 00:00:00', removalexitreason='CHREUNIFWF' FROM person p, servicecase sc WHERE r.personid = p.personid AND sc.servicecaseid = r.servicecaseid AND sc.servicecasenumber = '3278272' AND p.cjamspid = '4077700' AND trunc(r.removaldate) = '2017-06-14' AND r.activeflag = 1 and exitdate is null ;


