INSERT INTO cjams.assessmentactor(assessmentid, intakeservicerequestactorid,  activeflag, insertedby, updatedby,  insertedon, updatedon) 
SELECT ast.assessmentid
,isra.intakeservicerequestactorid
,1 
,'admin-D21797'
,'admin-D21797'
,Now() 
,Now()  
FROM intakeservicerequestactor isra 
inner join servicecase sc on sc.servicecaseid = isra.servicecaseid and sc.activeflag = 1
inner join person p on p.personid = isra.personid and p.activeflag = 1 
inner join assessmentsubmission  asb1 on asb1.datavalue = p.cjamspid and asb1.activeflag = 1 and asb1.datakey='clientid' 
inner join assessment ast on ast.assessmentid = asb1.assessmentid and ast.activeflag = 1 and  ast.assessmenttemplateid = 'f6e4c466-72ae-4453-9997-a2a12fcf8035' AND  ast.activeflag = 1  AND ast.submissiondata is not NULL 
 WHERE sc.servicecasenumber in 
(
SELECT  asb.datavalue 
FROM assessment asmt    
INNER JOIN assessmentsubmission asb ON asb.assessmentid = asmt.assessmentid   AND asb.activeflag = 1  AND asb.datakey='caseid'  
WHERE asmt.assessmenttemplateid = 'f6e4c466-72ae-4453-9997-a2a12fcf8035' 
AND  asmt.activeflag = 1  AND submissiondata is not NULL 
)
and p.cjamspid in 
(
SELECT  asb.datavalue 
FROM assessment asmt    
INNER JOIN assessmentsubmission asb ON asb.assessmentid = asmt.assessmentid   AND asb.activeflag = 1  AND asb.datakey='clientid'  
WHERE asmt.assessmenttemplateid = 'f6e4c466-72ae-4453-9997-a2a12fcf8035' 
AND  asmt.activeflag = 1  AND submissiondata is not NULL 
)
and isra.isprimary = 1 and isra.activeflag = 1
and ast.assessmentid not in (select  assessmentid from assessmentactor where activeflag = 1 )
order by p.cjamspid;