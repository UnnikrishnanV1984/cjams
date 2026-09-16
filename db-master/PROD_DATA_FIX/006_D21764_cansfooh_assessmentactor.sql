INSERT INTO cjams.assessmentactor(assessmentid, intakeservicerequestactorid,  activeflag, insertedby, updatedby,  insertedon, updatedon) 
SELECT asb.assessmentid 
,sbs.datavalue::uuid 
,1 
,'admin-D21764'
,'admin-D21764'
,Now() 
,Now() 
FROM assessment asmt    
inner join assessmentsubmission asb on asb.assessmentid = asmt.assessmentid  and asb.activeflag = 1  and asb.datakey='faceLifeForm' 
inner join submissioncollection sbs on sbs.assessmentsubmissionid = asb.assessmentsubmissionid  and sbs.activeflag = 1  and sbs.datakey='childname' 
WHERE asmt.assessmenttemplateid = '310c6895-e6eb-4bd0-8d67-fc8f37ddf8c2' 
AND asmt.activeflag = 1  
AND asmt.assessmentid::uuid NOT IN (select assessmentid from cjams.assessmentactor where activeflag = 1) 
ORDER BY assessmentid;