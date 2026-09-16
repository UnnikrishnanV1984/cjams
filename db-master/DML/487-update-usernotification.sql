UPDATE usernotification 
SET objecttype = 'intake', objectcasenumber = ids.intakenumber, updatedby = 'admin', updatedon = now()
FROM intakedastaging ids
WHERE ids.intakenumber = usernotification.objectid;

UPDATE usernotification 
SET objecttype = 'adoptioncase', objectcasenumber = (
SELECT ac.adoptioncasenumber FROM adoptioncase ac WHERE ac.adoptioncaseid = acd.adoptioncaseid), updatedby = 'admin', updatedon = now()
FROM adoptioncasedisposition acd
WHERE acd.adoptioncasedispositionid :: CHARACTER VARYING = usernotification.objectid;

UPDATE usernotification 
SET objecttype = 'adoptioncase', objectcasenumber = ac.adoptioncasenumber, updatedby = 'admin', updatedon = now()
FROM adoptioncase ac
WHERE ac.adoptioncaseid :: CHARACTER VARYING = usernotification.objectid;

UPDATE usernotification 
SET objecttype = 'servicecase', objectcasenumber = sc.servicecasenumber, updatedby = 'admin', updatedon = now()
FROM servicecase sc
WHERE sc.servicecaseid :: CHARACTER VARYING = usernotification.objectid;

UPDATE usernotification 
SET objecttype = 'cps', objectcasenumber = isr.servicerequestnumber, updatedby = 'admin', updatedon = now()
FROM intakeservicerequest isr
WHERE isr.intakeserviceid :: CHARACTER VARYING = usernotification.objectid;

UPDATE usernotification 
SET objecttype = 'servicecase', objectcasenumber = (
SELECT tsl.case_id :: CHARACTER VARYING FROM tb_service_log tsl
INNER JOIN servicecase sc ON sc.servicecasenumber = tsl.case_id 
WHERE tspa.service_log_id = tsl.service_log_id ORDER BY sc.insertedon LIMIT 1), updatedby = 'admin', updatedon = now()
FROM tb_service_purchase_authorization tspa
WHERE tspa.authorization_id :: CHARACTER VARYING = usernotification.objectid;

UPDATE usernotification 
SET objecttype = 'cps', objectcasenumber = (
SELECT tsl.case_id :: CHARACTER VARYING FROM tb_service_log tsl
INNER JOIN intakeservicerequest isr ON isr.servicerequestnumber = tsl.case_id 
WHERE tspa.service_log_id = tsl.service_log_id ORDER BY isr.insertedon LIMIT 1), updatedby = 'admin', updatedon = now()
FROM tb_service_purchase_authorization tspa
WHERE tspa.authorization_id :: CHARACTER VARYING = usernotification.objectid;

UPDATE usernotification 
SET objecttype = 'servicecase', objectcasenumber = (
SELECT sc.servicecasenumber FROM servicecase sc WHERE sc.servicecaseid = scd.servicecaseid), updatedby = 'admin', updatedon = now()
FROM servicecasedisposition scd
WHERE scd.servicecasedispositionid :: CHARACTER VARYING = usernotification.objectid;

UPDATE usernotification 
SET objecttype = 'servicecase', objectcasenumber = (
SELECT sc.servicecasenumber FROM servicecase sc WHERE sc.servicecaseid = pl.servicecaseid), updatedby = 'admin', updatedon = now()
FROM placement pl
WHERE pl.placementid :: CHARACTER VARYING = usernotification.objectid;

UPDATE usernotification 
SET objecttype = 'servicecase', objectcasenumber = (
SELECT sc.servicecasenumber FROM servicecase sc WHERE sc.servicecaseid = pp.servicecaseid), updatedby = 'admin', updatedon = now()
FROM permanencyplan pp
WHERE pp.permanencyplanid :: CHARACTER VARYING = usernotification.objectid;

UPDATE usernotification 
SET objecttype = 'servicecase', objectcasenumber = (
SELECT servicecasenumber FROM servicecase sc
INNER JOIN guardianship gp ON gp.servicecaseid = sc.servicecaseid 
WHERE gp.gapid = ga.gapid ORDER BY sc.insertedon LIMIT 1), updatedby = 'admin', updatedon = now()
FROM gapagreement ga
WHERE ga.gapagreementid :: CHARACTER VARYING = usernotification.objectid;

UPDATE usernotification 
SET objecttype = 'cps', objectcasenumber = (
SELECT servicerequestnumber FROM intakeservicerequest isr
INNER JOIN guardianship gp ON gp.intakeserviceid = isr.intakeserviceid 
WHERE gp.gapid = ga.gapid ORDER BY isr.insertedon LIMIT 1), updatedby = 'admin', updatedon = now()
FROM gapagreement ga
WHERE ga.gapagreementid :: CHARACTER VARYING = usernotification.objectid;

UPDATE usernotification 
SET objecttype = 'servicecase', objectcasenumber = (
SELECT sc.servicecasenumber FROM servicecase sc WHERE sc.servicecaseid = isrcr.servicecaseid), updatedby = 'admin', updatedon = now()
FROM intakeservreqchildremoval isrcr
WHERE isrcr.intakeservreqchildremovalid :: CHARACTER VARYING = usernotification.objectid;

UPDATE usernotification 
SET objecttype = 'cps', objectcasenumber = (
SELECT isr.servicerequestnumber FROM intakeservicerequest isr WHERE isr.intakeserviceid = isrcr.intakeserviceid ), updatedby = 'admin', updatedon = now()
FROM intakeservreqchildremoval isrcr
WHERE isrcr.intakeservreqchildremovalid :: CHARACTER VARYING = usernotification.objectid AND isrcr.servicecaseid IS NULL;