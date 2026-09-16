INSERT INTO cjams.assessmentactor(assessmentid, intakeservicerequestactorid,  activeflag, insertedby, updatedby,  insertedon, updatedon) 
SELECT  ast.assessmentid
,sca.datavalue::uuid
, 1
,'admin-D21726'
,'admin-D21726'
,Now()
,Now() 
FROM submissioncollection sca
INNER JOIN assessmentsubmission asb on asb.assessmentsubmissionid = sca.assessmentsubmissionid AND asb.activeflag = 1 
INNER JOIN assessment ast on ast.assessmentid = asb.assessmentid AND ast.activeflag=  1 AND ast.assessmenttemplateid ='e348d7c4-a392-447a-ba42-17078941a721' AND ast.submissiondata  IS  NOT NULL
WHERE asb.datakey = 'child' AND sca.datakey = 'childlist'
AND ast.assessmentid  NOT IN (select assessmentid from cjams.assessmentactor where activeflag = 1)
ORDER BY ast.assessmentid ;