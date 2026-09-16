--ASSESSMENT DELETE 
UPDATE assessment SET activeflag = 0 
, updatedby = 'admin-D23572'
,updatedon = Now() 
WHERE assessmenttemplateid='e348d7c4-a392-447a-ba42-17078941a721' 
AND  servicecaseid = '7abb16c2-3646-4107-a77c-24cae66c836b'  
AND assessmentstatustypekey='InProcess'  
AND activeflag=1
AND assessmentid IN
			(
			'bb432fbc-88f8-4504-a269-97a3602b68a5',
			'0bdf4e52-8480-4550-80a1-b42b8a4dd020'
			);
 

--ASSESSMENTACTOR DELETE /currently no records for the above assessments
UPDATE assessmentactor SET activeflag = 0 , updatedby = 'admin-D23572',updatedon = Now()  
WHERE 
		assessmentid IN 
		(
			SELECT assessmentid FROM assessment WHERE assessmenttemplateid='e348d7c4-a392-447a-ba42-17078941a721' 
			AND  servicecaseid = '7abb16c2-3646-4107-a77c-24cae66c836b'  
			AND assessmentstatustypekey='InProcess' 
			AND assessmentid IN
						(
						'bb432fbc-88f8-4504-a269-97a3602b68a5',
						'0bdf4e52-8480-4550-80a1-b42b8a4dd020'
						)
		) 
AND activeflag=1;

		
--assessmentsubmission DELETE 

UPDATE assessmentsubmission SET activeflag = 0 , updatedby = 'admin-D23572',updatedon = Now()  
WHERE 
		assessmentid IN 
		(
			SELECT assessmentid FROM assessment WHERE assessmenttemplateid='e348d7c4-a392-447a-ba42-17078941a721' 
			AND  servicecaseid = '7abb16c2-3646-4107-a77c-24cae66c836b'  
			AND assessmentstatustypekey='InProcess' 
			AND assessmentid IN
						(
						'bb432fbc-88f8-4504-a269-97a3602b68a5',
						'0bdf4e52-8480-4550-80a1-b42b8a4dd020'
						)
		) 
AND activeflag=1; 


--submissioncollection DELETE   
UPDATE submissioncollection SET activeflag = 0 , updatedby = 'admin-D23572',updatedon = Now()  
WHERE 
	assessmentsubmissionid IN 
	   (SELECT assessmentsubmissionid FROM assessmentsubmission WHERE assessmentid IN 
			(	SELECT assessmentid FROM assessment WHERE assessmenttemplateid='e348d7c4-a392-447a-ba42-17078941a721' 
				AND  servicecaseid = '7abb16c2-3646-4107-a77c-24cae66c836b'  
				AND assessmentstatustypekey='InProcess' 
				AND assessmentid IN
					(
					'bb432fbc-88f8-4504-a269-97a3602b68a5',
					'0bdf4e52-8480-4550-80a1-b42b8a4dd020'
					)
			)
		) 
AND activeflag=1; 