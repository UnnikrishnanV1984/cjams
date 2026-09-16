update assessment a
set submissiondata =  (select * FROM  getsubmissiondetails(a.submissionid)), updatedby = 'CIDM-9712',
updatedon = now() from assessmenttemplate ast 
where a.assessmenttemplateid = ast.assessmenttemplateid
and a.ismigrated = 1 and a.submissionid is not null and submissiondata is null and a.activeflag = 1
and ast.activeflag = 1 and ast."name" = 'safeCOhp';
