UPDATE cjams.assessmentsubmission 
SET  
 datavalue = '',
 updatedon = now(),
 updatedby = 'admin'
WHERE  
assessmentid = '8db4c869-8695-4ec4-8d4e-ce5e2dde7596'  
and datakey = 'dateoflastsafetyplan'
and activeflag = 1;

UPDATE cjams.assessment
SET submissiondata = jsonb_set(submissiondata, '{dateoflastsafetyplan}','""')
WHERE assessmentid = '8db4c869-8695-4ec4-8d4e-ce5e2dde7596';
