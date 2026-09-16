INSERT INTO cjams.assessmentactor(assessmentid, intakeservicerequestactorid,  activeflag, insertedby, updatedby,  insertedon, updatedon) 
 SELECT  ast.assessmentid 
    ,isra.intakeservicerequestactorid 
    ,1 
	,'admin-D22190'
	,'admin-D22190'
	,Now() 
	,Now() 
FROM assessment ast  
INNER JOIN assessmentsubmission astsb ON astsb.assessmentid =  ast.assessmentid AND astsb.activeflag = 1 AND astsb.datakey = 'familygrid'
INNER JOIN submissioncollection sct ON sct.assessmentsubmissionid =  astsb.assessmentsubmissionid AND sct.activeflag = 1 AND sct.datakey::text = 'childrenname'
INNER JOIN person p ON  trim(both FROM COALESCE(p.firstname, '') || ' ' || COALESCE(p.middlename, '') || ' ' || COALESCE(p.lastname, '')) =  sct.datavalue::text AND p.activeflag = 1
INNER JOIN intakeservicerequestactor isra ON isra.personid =p.personid AND isra.servicecaseid = ast.servicecaseid AND isra.isprimary = true AND isra.activeflag = 1 
WHERE ast.assessmenttemplateid = 'bfbd189c-65c6-4e6d-aa93-2655aa0f1a77'
AND ast.submissiondata IS NOT NULL --
AND ast.assessmentid NOT IN (SELECT assessmentid FROM assessmentactor WHERE activeflag =1 );