INSERT INTO cjams.assessmentactor(assessmentid, intakeservicerequestactorid,  activeflag, insertedby, updatedby,  insertedon, updatedon) 
select * from  (
SELECT  ast.assessmentid
    ,isra.intakeservicerequestactorid
    ,1
,'admin-D21658'
,'admin-D21658'
,Now()
,Now()
 from assessment ast  
INNER JOIN intakeservicerequestactor isra on isra.intakeserviceid = ast.objectid  AND isra.isprimary = true AND isra.activeflag = 1
INNER JOIN person p   on p.personid = isra.personid  AND p.activeflag = 1  
where  ast.assessmenttemplateid = 'ba9b5838-e8ab-434b-9871-3611e86c314d'
AND ast.submissiondata IS NOT NULL  
and trim(both FROM COALESCE(p.firstname, '') || ' ' || COALESCE(p.middlename, '') || ' ' || COALESCE(p.lastname, ''))
in (
trim(ast.submissiondata->'familyHOUSEHOLD'->'familyArray'->0->>'name'::text),
trim(ast.submissiondata->'familyHOUSEHOLD'->'familyArray'->1->>'name'::text),
trim(ast.submissiondata->'familyHOUSEHOLD'->'familyArray'->2->>'name'::text),
trim(ast.submissiondata->'familyHOUSEHOLD'->'familyArray'->3->>'name'::text),
trim(ast.submissiondata->'familyHOUSEHOLD'->'familyArray'->4->>'name'::text),
trim(ast.submissiondata->'familyHOUSEHOLD'->'familyArray'->5->>'name'::text),
trim(ast.submissiondata->'familyHOUSEHOLD'->'familyArray'->6->>'name'::text),
trim(ast.submissiondata->'familyHOUSEHOLD'->'familyArray'->7->>'name'::text),
trim(ast.submissiondata->'familyHOUSEHOLD'->'familyArray'->8->>'name'::text),
trim(ast.submissiondata->'familyHOUSEHOLD'->'familyArray'->9->>'name'::text)

)
and ast.servicecaseid is  null 
and ast.assessmentid  not in (select assessmentid from assessmentactor where activeflag=1 )
union all
SELECT  ast.assessmentid
    ,isra.intakeservicerequestactorid
    ,1
,'admin-D21658'
,'admin-D21658'
,Now()
,Now()
 from assessment ast  
INNER JOIN intakeservicerequestactor isra on isra.servicecaseid = ast.servicecaseid  AND isra.isprimary = true AND isra.activeflag = 1
INNER JOIN person p   on p.personid = isra.personid  AND p.activeflag = 1  
where  ast.assessmenttemplateid = 'ba9b5838-e8ab-434b-9871-3611e86c314d'
AND ast.submissiondata IS NOT NULL  
and trim(both FROM COALESCE(p.firstname, '') || ' ' || COALESCE(p.middlename, '') || ' ' || COALESCE(p.lastname, ''))
in (
trim(ast.submissiondata->'familyHOUSEHOLD'->'familyArray'->0->>'name'::text),
trim(ast.submissiondata->'familyHOUSEHOLD'->'familyArray'->1->>'name'::text),
trim(ast.submissiondata->'familyHOUSEHOLD'->'familyArray'->2->>'name'::text),
trim(ast.submissiondata->'familyHOUSEHOLD'->'familyArray'->3->>'name'::text),
trim(ast.submissiondata->'familyHOUSEHOLD'->'familyArray'->4->>'name'::text),
trim(ast.submissiondata->'familyHOUSEHOLD'->'familyArray'->5->>'name'::text),
trim(ast.submissiondata->'familyHOUSEHOLD'->'familyArray'->6->>'name'::text),
trim(ast.submissiondata->'familyHOUSEHOLD'->'familyArray'->7->>'name'::text),
trim(ast.submissiondata->'familyHOUSEHOLD'->'familyArray'->8->>'name'::text),
trim(ast.submissiondata->'familyHOUSEHOLD'->'familyArray'->9->>'name'::text)

)
and ast.servicecaseid is not null 
and ast.assessmentid  not in (select assessmentid from assessmentactor where activeflag=1 )
 )
asta
order by asta.assessmentid asc; 