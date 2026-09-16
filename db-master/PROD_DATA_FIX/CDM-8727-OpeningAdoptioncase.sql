
update adoptioncase set enddate = '2024-01-28 00:00:00', statustypekey = 'Open', updatedby = 'CDM-8727', updatedon = now() 
where adoptioncasenumber = '3212684';

update adoptioncaseagreement set enddate = '2024-01-28 00:00:00', updatedby = 'CDM-8727', updatedon = now() 
where adoptioncaseid = 'd780b415-bf6f-4716-901b-ade6da4ae99c';

update personprogramarea set enddate = null , updatedby = 'CDM-8727', updatedon = now() where personprogramid = 'c5253193-7151-4f1c-9d3f-2f61f2d0ec16';


INSERT INTO cjams.adoptioncasedisposition
(adoptioncaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date)
VALUES('d780b415-bf6f-4716-901b-ade6da4ae99c'::uuid, now(), 'Reopen', 'Inprogress', 'Adoption Case Re-Opened', now(), 1, 'CDM-8727', now(), 'CDM-8727', now(), NULL, NULL, NULL, NULL);


INSERT INTO cjams.caseassignment
(fromworkeridno, fromsupervisoridno, fromofficecode, toworkeridno, tosupervisoridno, toofficecode, caseassigncode, effectivedate, effectivetime, frombizunitidno, tobizunitidno, old_id, foldergroupindc, cmfldrgrpasgnkey, insertedby, updatedby, insertedon, updatedon, objecttypekey, objectid, responsibilitytypekey, activeflag, startdate, fromteamid, toteamid, remarks, statustypekey, fromldssid, toldssid, assignmenttype, fk_id, assigndate, isrestricted, assigndescription, summary, isnew, expungementflag, entityopendate)
VALUES('27920e1e-978e-4231-a9d5-ea7323ceb413', '867', NULL, '27920e1e-978e-4231-a9d5-ea7323ceb413', '867', NULL, NULL, NULL, NULL, NULL, NULL, '3212684', NULL, NULL, 'BWO400315', 'BWO400315', NOW(), NOW() , 'adoptioncase', 'd780b415-bf6f-4716-901b-ade6da4ae99c'::uuid, 'family', 1, NOW(), 'f8348f64-e5d4-4ee9-8cf4-2fe3627446fb'::uuid, 'f8348f64-e5d4-4ee9-8cf4-2fe3627446fb'::uuid, NULL, NULL, 'f6ab02d5-c386-4659-8810-687fc191a967'::uuid, 'f6ab02d5-c386-4659-8810-687fc191a967'::uuid, 'W', '5976346', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
