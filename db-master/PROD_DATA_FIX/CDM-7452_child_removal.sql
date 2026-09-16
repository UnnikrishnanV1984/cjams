
--CDM-6229 remove living arrangement
UPDATE placementrevision SET activeflag = 0, updatedby = 'CDM-6229', 
updatedon = now() WHERE activeflag = 1 AND placementid ='be423e47-5867-4df2-a714-e6385dc60816';

UPDATE placement SET activeflag = 0, updatedby = 'CDM-6229', updatedon = now() WHERE activeflag = 1 AND alternateid = 1557100;

UPDATE livingarrangement SET activeflag = 0, updatedby = 'CDM-6229', 
updatedon = now() WHERE activeflag = 1 AND placementid ='be423e47-5867-4df2-a714-e6385dc60816';


--CDM-5577 - adption case assigment object type is changed from service request to adoptioncase
UPDATE caseassignment ca SET ca.objecttypekey = 'adoptioncase', updatedby = 'CDM-5577', updatedon = now() 
FROM adoptioncase ac 
WHERE ac.adoptioncaseid = ca.objectid AND ca.activeflag = 1
AND ca.objecttypekey = 'servicerequest' 
AND ac.adoptioncasenumber IN (3255019, 3264428, 3266369, 3279114, 3279115, 3279118, 3286489, 3295095) ;

--CDM-6664 - child removal end date - case 3228285
UPDATE intakeservreqchildremoval SET removalexitreason = 'REUNIF', exitdate = '2020-09-24 09:00:00', updatedon = now(), 
updatedby = 'CDM-6664' WHERE removalid in (197406, 162830) AND activeflag = 1 and (removalexitreason is null or exitdate is null );

--CDM-7570 - update removal date

UPDATE intakeservreqchildremoval SET removalexitreason = 'REUNIF', exitdate = '2020-10-02 09:00:00', updatedon = now(), 
updatedby = 'CDM-7570' WHERE removalid in (195504, 194749) AND activeflag = 1 and (removalexitreason is null or exitdate is null );

UPDATE placement pl SET pl.enddatetime = '2020-10-02 09:00:00', pl.updatedon = now(), 
pl.updatedby = 'CDM-7570' FROM person p WHERE p.personid = pl.personid
AND pl.activeflag = 1 AND enddatetime IS NULL AND pl.placementtypekey = 'LA'
AND p.cjamspid IN (4205907, 4365668);

UPDATE livingarrangement SET livingenddate = '2020-10-02 09:00:00', updatedon = now(), 
updatedby = 'CDM-7570' WHERE livingid IN ('8d9ea539-14d1-4ca7-82e7-66c49a4cad7a', '23f3bec0-8a52-4000-ab6c-e7518f95d725'); 

-- CDM-7452 - update removal, placement

-- placement update
UPDATE placement pl SET pl.enddatetime = '2020-09-03 09:00:00', pl.updatedon = now(), 
pl.updatedby = 'CDM-7452' FROM person p WHERE p.personid = pl.personid
AND pl.activeflag = 1 AND enddatetime IS NULL AND pl.placementtypekey = 'LA'
AND p.cjamspid IN (2207244, 3466067, 3873944);

-- Living arrangement update
UPDATE livingarrangement lv SET lv.livingenddate = '2020-09-03 09:00:00', lv.updatedon = now(), 
lv.updatedby = 'CDM-7452' FROM placement pl, person p WHERE lv.placementid = pl.placementid
AND pl.personid = p.personid AND pl.activeflag = 1 AND enddatetime = '2020-09-03 09:00:00' AND pl.placementtypekey = 'LA'
AND p.cjamspid IN (2207244, 3466067, 3873944) AND pl.updatedby = 'CDM-7452';

--Child removal update
UPDATE intakeservreqchildremoval r SET r.removalexitreason = 'REUNIF', r.exitdate = '2020-09-03 09:00:00', 
r.updatedon = now(), r.updatedby = 'CDM-7452' FROM
servicecase sc, person p
WHERE r.servicecaseid = sc.servicecaseid AND r.personid = p.personid 
AND sc.servicecasenumber IN (3162775) AND p.cjamspid IN (2207244, 3466067, 3873944)
AND r.activeflag = 1 AND r.exitdate IS NULL ;

-- Proram assignment update
UPDATE personprogramarea ppa SET enddate = '2020-09-03 15:57:26', updatedon = now(), 
ppa.updatedby = 'CDM-7452' FROM person p 
WHERE p.cjamspid IN (2207244, 3466067, 3873944) AND ppa.entityid = 3162775
AND ppa.programkey = 'OOH' AND ppa.activeflag = 1  AND trunc(enddate) = '2020-10-13';

