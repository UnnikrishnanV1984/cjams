/*
Issue Description: CJAMS-66527
Category/ Module  :  Assesments
Root cause:Due to missing child information in the assessmnet form,
the assessment is not shown on the UI, But the notification is
there on the approval inbox and user wants
us to remove that assessment record since user has
created a new assessment and have submitted for approval. 
Fix provided: Data fix has been done to remove the assessment from approval inbox
Pull request# for code fix: 
Reason why no related code fix: Issue is not replicable in stage3
Status of the code fix if already submitted and expected prod fix date: 
 */
update assessment a
set
    activeflag = 0,
    updatedby = 'CJAMS-66527',
    updatedon = now ()
where
    assessmentid = '8d0e290b-7c70-4448-9686-b61c421041b2'
    and activeflag = 1;

    -----no record in assessmentactor

      update assessmentcomments 
set
    activeflag = 0,
    updatedby = 'CJAMS-66527',
    updatedon = now ()
where
    assessmentid = '8d0e290b-7c70-4448-9686-b61c421041b2'
    and activeflag = 1;
   
     update assessment_history 
set
    activeflag = 0,
    updatedby = 'CJAMS-66527',
    updatedon = now ()
where
    assessmentid = '8d0e290b-7c70-4448-9686-b61c421041b2'
    and activeflag = 1;

    ----No record in assessmentsubmission 
   
 update routing
set
    activeflag = 0,
    updatedby = 'CJAMS-66527',
    updatedon = now ()
where
    objectid = '8d0e290b-7c70-4448-9686-b61c421041b2'
    and activeflag = 1 and  eventcode='ASST';