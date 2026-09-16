-- update primary flag for cjamspid = 200003975
--CDM-269 202005601000

UPDATE intakeservicerequestactor SET isprimary = TRUE, updatedon = now() 
WHERE intakeservicerequestactorid IN 
(SELECT intakeservicerequestactorid FROM intakeservicerequestactor a, intakeservicerequest i
WHERE a.intakeserviceid = i.intakeserviceid AND a.personid = '6ed919b5-e4d6-44de-8a74-89ff74f087a1'
AND a.activeflag = 1 AND a.intakeservicerequestpersontypekey = 'AV' AND a.isprimary = FALSE ); 


UPDATE intakeservicerequestactor SET isprimary = FALSE, servicecaseid = 'fc23354e-7c05-40da-8807-d7d5533ed7da', 
updatedon = now() WHERE intakeservicerequestactorid IN 
(SELECT intakeservicerequestactorid FROM intakeservicerequestactor a, intakeservicerequest i
WHERE a.intakeserviceid = i.intakeserviceid AND a.personid = '6ed919b5-e4d6-44de-8a74-89ff74f087a1'
AND a.activeflag = 1 AND a.intakeservicerequestpersontypekey = 'CHILD' AND a.isprimary = TRUE ); 
