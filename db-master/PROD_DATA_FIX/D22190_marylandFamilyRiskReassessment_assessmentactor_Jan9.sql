INSERT INTO cjams.assessmentactor(assessmentid, intakeservicerequestactorid,  activeflag, insertedby, updatedby,  insertedon, updatedon) 
SELECT * FROM  (
	SELECT  ast.assessmentid
		,isra.intakeservicerequestactorid
		,1
		,'admin-D22190'
		,'admin-D22190'
		,Now()
		,Now()
	 FROM assessment ast  
	INNER JOIN intakeservicerequestactor isra on isra.servicecaseid = ast.servicecaseid  AND isra.isprimary = true AND isra.activeflag = 1
	INNER JOIN person p   on p.personid = isra.personid  AND p.activeflag = 1  
	WHERE  ast.assessmenttemplateid = 'bfbd189c-65c6-4e6d-aa93-2655aa0f1a77'
	AND ast.submissiondata IS NOT NULL  
	AND trim(both FROM COALESCE(p.firstname, '') || ' ' || COALESCE(p.middlename, '') || ' ' || COALESCE(p.lastname, ''))
	IN ( 
		trim(ast.submissiondata->'familygrid'->0->>'childrenname'::text) 
		,trim(ast.submissiondata->'familygrid'->1->>'childrenname'::text) 
		,trim(ast.submissiondata->'familygrid'->2->>'childrenname'::text)
		,trim(ast.submissiondata->'familygrid'->3->>'childrenname'::text) 
		,trim(ast.submissiondata->'familygrid'->4->>'childrenname'::text)  
		,trim(ast.submissiondata->'familygrid'->5->>'childrenname'::text) 
		,trim(ast.submissiondata->'familygrid'->6->>'childrenname'::text)
		,trim(ast.submissiondata->'familygrid'->7->>'childrenname'::text)  
		)
	AND ast.assessmentid  NOT IN (SELECT assessmentid FROM assessmentactor WHERE activeflag=1 )
 ) asta
ORDER BY asta.assessmentid ASC; 