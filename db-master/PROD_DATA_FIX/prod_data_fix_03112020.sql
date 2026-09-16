-- D-12190 set relationship to self

update assessmentsubmission set datavalue = 'Self' 
where activeflag = 1 and datakey = 'relationship' and datavalue = 'Boyfriend-ex'
and submissionid in (select submissionid from assessment a, servicecase s where s.servicecaseid = a.servicecaseid
and servicecasenumber = '3235152' and assessmenttemplateid = '0f01e16c-73db-42d8-ad84-04eeb5e26418' 
and a.activeflag = 1 and ismigrated = 0 ) ;

--D-25219 download is not working
update documentproperties set activeflag = 0 where documentpropertiesid = 'fec06161-3c17-493d-8831-fc4792ce8b63' ;

--D-25374 remove the case
update servicecase set statustypekey = 'Closed', dispositioncode = 'Closed', enddate = now(), activeflag = 0,
updatedby = 'D-25374', updatedon = now() where servicecasenumber = 20200210867 ;

UPDATE intakeservicerequestactor set servicecaseid = null, updatedby = 'D-25374' where servicecaseid in 
(select servicecaseid from servicecase where servicecasenumber = 20200210867);

-- D-27558 Child Removal
INSERT INTO personprogramarea (
personid, programkey, subprogramkey, objecttypekey, objectid, 
startdate, insertedby, insertedon, updatedby, updatedon, 
entityid, datatransferflag, activeflag
) values(
'49d0b177-f160-4759-bc27-4c7ab7a17835', 'OOH', null, 'servicecase', '532abae4-7dc3-47bc-96cf-7cd26db92cea', 
'2020-03-05 00:00:00', '98b33fbc-7c40-47fa-8e83-101e7aab4d05', '2020-03-05 00:00:00', '98b33fbc-7c40-47fa-8e83-101e7aab4d05', now(), 
'3181268', 'A', 1
) ;

-- D-27407 Child Removal
INSERT INTO personprogramarea (
personid, programkey, subprogramkey, objecttypekey, objectid, 
startdate, insertedby, insertedon, updatedby, updatedon, 
entityid, datatransferflag, activeflag
) values(
'8610f644-5244-4abc-94e9-5929de21de62', 'OOH', null, 'servicecase', 'cd356070-a9ba-4163-ab1e-5af802611286', 
'2020-03-05 00:00:00', 'ee147827-c892-4d56-8d77-0eb589ac7074', '2020-03-05 00:00:00', 'ee147827-c892-4d56-8d77-0eb589ac7074', now(), 
'202006901042', 'A', 1
) ;

