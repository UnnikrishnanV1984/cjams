INSERT INTO cjams.assessmentactor(assessmentid, intakeservicerequestactorid,  activeflag, insertedby, updatedby,  insertedon, updatedon) 
SELECT  * FROM  (
		SELECT  ast.assessmentid
		    ,isra.intakeservicerequestactorid
		    ,1
			,'admin-D23583'
			,'admin-D23583'
			,Now()
			,Now()
		    FROM assessment ast  
				INNER JOIN intakeservicerequestactor isra on isra.servicecaseid = ast.servicecaseid  AND isra.isprimary = true AND isra.activeflag = 1
				INNER JOIN person p ON p.personid = isra.personid  AND p.activeflag = 1  
				WHERE  ast.assessmenttemplateid = '0f01e16c-73db-42d8-ad84-04eeb5e26418'
				AND ast.submissiondata IS NOT NULL  
				AND LENGTH(trim(ast.submissiondata->'addchildren'->0->>'seconename'::text)) > 2
				AND trim(both FROM COALESCE(p.firstname, '') || ' ' || COALESCE(p.lastname, ''))
				IN (trim(ast.submissiondata->'addchildren'->0->>'seconename'::text) --as first_child_other 
				,trim(ast.submissiondata->'addchildren'->1->>'seconename'::text)  --as second_child_other 
				,trim(ast.submissiondata->'addchildren'->2->>'seconename'::text) --as third_child_other 
				,trim(ast.submissiondata->'addchildren'->3->>'seconename'::text) --as four_child_other 
				,trim(ast.submissiondata->'addchildren'->4->>'seconename'::text) --as five_child_other 
				,trim(ast.submissiondata->'addchildren'->5->>'seconename'::text) --as six_child_other 
				,trim(ast.submissiondata->'addchildren'->6->>'seconename'::text) --as seven_child_other   
				)
				AND isra.intakeservicerequestactorid not in (SELECT intakeservicerequestactorid FROM assessmentactor asta 
							WHERE activeflag= 1 
							AND asta.assessmentid =  ast.assessmentid)
)
asta
ORDER BY asta.assessmentid ASC; 