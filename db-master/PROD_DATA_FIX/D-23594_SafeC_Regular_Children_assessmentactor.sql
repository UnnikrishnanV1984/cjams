INSERT INTO cjams.assessmentactor(assessmentid, intakeservicerequestactorid,  activeflag, insertedby, updatedby,  insertedon, updatedon) 
SELECT  * FROM  (
      SELECT  ast.assessmentid
		    ,isra.intakeservicerequestactorid
		    ,1
			,'admin-D23594'
			,'admin-D23594'
			,Now()
			,Now()
		    FROM assessment ast  
				INNER JOIN intakeservicerequestactor isra on isra.servicecaseid = ast.servicecaseid  AND isra.isprimary = true AND isra.activeflag = 1
				INNER JOIN person p ON p.personid = isra.personid  AND p.activeflag = 1  
				WHERE  ast.assessmenttemplateid = '0f01e16c-73db-42d8-ad84-04eeb5e26418'
				AND ast.submissiondata IS NOT NULL   
				AND trim(both FROM COALESCE(p.firstname, '') || ' ' || COALESCE(p.lastname, ''))
				IN (
					trim(ast.submissiondata->'childdatagrid'->0->>'childname'::text) --as first_child_regular 
					 ,trim(ast.submissiondata->'childdatagrid'->1->>'childname'::text) --as second_child_regular 
					,trim(ast.submissiondata->'childdatagrid'->2->>'childname'::text) --as third_child_regular 
					 ,trim(ast.submissiondata->'childdatagrid'->3->>'childname'::text) --as four_child_regular  
					,trim(ast.submissiondata->'childdatagrid'->4->>'childname'::text) --as five_child_regular 
					,trim(ast.submissiondata->'childdatagrid'->5->>'childname'::text) --as six_child_regular   
					)
				AND isra.intakeservicerequestactorid not in (SELECT intakeservicerequestactorid FROM assessmentactor asta 
							WHERE activeflag= 1 
							AND asta.assessmentid =  ast.assessmentid)
		)
		asta
ORDER BY asta.assessmentid ASC; 