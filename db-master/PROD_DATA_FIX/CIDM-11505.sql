/*
Issue Description: CIDM-11505
Category/ Module  :  Assesments
Root cause:Due to missing child information in the assessmnet form,
the assessment is not shown on the UI, But the notification is
there on the approval inbox and user wants
us to remove that assessment record since user has
created a new assessment and have submitted for approval. 
Fix provided: Data fix has been done to remove the assessment from approval inbox
Pull request# for code fix: 
Reason why no related code fix: code fix is done aspart of CDM-44832
Status of the code fix if already submitted and expected prod fix date: 
 */



update assessment a
set
    activeflag = 0,
    updatedby = 'CIDM-11505',
    updatedon = now ()
where
    assessmentid = 'd3f34e1e-7ba5-4d3b-b3e5-94f00ed987f5'
    and activeflag = 1;

    -----no record in assessmentactor

      update assessmentcomments 
set
    activeflag = 0,
    updatedby = 'CIDM-11505',
    updatedon = now ()
where
    assessmentid = 'd3f34e1e-7ba5-4d3b-b3e5-94f00ed987f5'
    and activeflag = 1;
   
     update assessment_history 
set
    activeflag = 0,
    updatedby = 'CIDM-11505',
    updatedon = now ()
where
    assessmentid = 'd3f34e1e-7ba5-4d3b-b3e5-94f00ed987f5'
    and activeflag = 1;

    ----No record in assessmentsubmission 
   
 update routing
set
    activeflag = 0,
    updatedby = 'CIDM-11505',
    updatedon = now ()
where
    objectid = 'd3f34e1e-7ba5-4d3b-b3e5-94f00ed987f5'
    and activeflag = 1 and  eventcode='ASST';