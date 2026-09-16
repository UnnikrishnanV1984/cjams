/*
   Issue Description: CJAMS-59096
   Category/ Module  : Prod data fix To remove two MFIRA approved assessments
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
update assessment
set activeflag= 0,
	updatedby = 'CJAMS-59096',
	updatedon = now()
where assessmentid in  (
'6e467146-fa8f-4119-aa33-aab147e15fcc',
'73b21dcc-6570-4f33-8d9b-190f7a9ba9d2'
)
and activeflag = 1;

update assessment_history
set activeflag= 0,
	updatedby = 'CJAMS-59096',
	updatedon = now()
where assessmentid in  (
'6e467146-fa8f-4119-aa33-aab147e15fcc',
'73b21dcc-6570-4f33-8d9b-190f7a9ba9d2'
)
and activeflag = 1;

update assessmentactor
set activeflag = 0,
    updatedby = 'CJAMS-59096',
    updatedon = now()    
where assessmentid in  (
'6e467146-fa8f-4119-aa33-aab147e15fcc',
'73b21dcc-6570-4f33-8d9b-190f7a9ba9d2'
)
and activeflag = 1;

update assessmentcomments
set activeflag = 0,
    updatedby = 'CJAMS-59096',
    updatedon = now()    
where assessmentid in  (
'6e467146-fa8f-4119-aa33-aab147e15fcc',
'73b21dcc-6570-4f33-8d9b-190f7a9ba9d2'
)
and activeflag = 1;

update routing
set activeflag = 0,
    updatedby = 'CJAMS-59096',
    updatedon = now()
where objectid in (
'6e467146-fa8f-4119-aa33-aab147e15fcc',
'73b21dcc-6570-4f33-8d9b-190f7a9ba9d2'
)
and activeflag = 1;