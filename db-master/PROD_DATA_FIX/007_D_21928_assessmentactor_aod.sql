INSERT INTO cjams.assessmentactor(assessmentid, intakeservicerequestactorid,  activeflag, insertedby, updatedby,  insertedon, updatedon) 
SELECT  ast.assessmentid
,sca.datavalue::uuid
, 1
,'admin-D21928'
,'admin-D21928'
,Now()
,Now() 
FROM submissioncollection sca
INNER JOIN assessmentsubmission asb on asb.assessmentsubmissionid = sca.assessmentsubmissionid AND asb.activeflag = 1 
INNER JOIN assessment ast on ast.assessmentid = asb.assessmentid AND ast.activeflag=  1 AND ast.assessmenttemplateid ='2c314922-2285-45e2-b49c-24b31993ac96' AND ast.submissiondata  IS  NOT NULL
WHERE asb.datakey = 'preliminaryForm' AND sca.datakey in('client', 'ispositivedrugscreenchild')
AND ast.assessmentid  NOT IN (select assessmentid from cjams.assessmentactor where activeflag = 1)
ORDER BY assessmentid ;