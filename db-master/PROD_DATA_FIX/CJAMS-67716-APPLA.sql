/*
Issue Description: CJAMS-67716
Category/ Module  :  Assesments
Root cause:On the supervisor's (kevin.buckley@maryland.gov) Approval Inbox, APPLA is showing up in Assessments Pending Approval, submitted on 05/04/2026.  But on the Case# 3175162 and 202106306373 the submission (Mency, Helen) is not showing up in APPLA (Permanency Plan) for approval.  Need in- depth analysis to figure out why the submitted data is not showing up in Permanency Plan and provide a fix.  
Fix provided: Data fix has been done to remove the assessment from approval inbox
Pull request# for code fix: 
Reason why no related code fix: Issue is not replicable in stage3
Status of the code fix if already submitted and expected prod fix date:

 */

--202106306373
update assessment a
set
    activeflag = 0,
    updatedby = 'CJAMS-67716',
    updatedon = now ()
where
    assessmentid = '7dbf9442-8dd9-4bb0-a4ff-8a15d164ef7a'
    and activeflag = 1;

    -----no record in assessmentactor

      update assessmentcomments 
set
    activeflag = 0,
    updatedby = 'CJAMS-67716',
    updatedon = now ()
where
    assessmentid = '7dbf9442-8dd9-4bb0-a4ff-8a15d164ef7a'
    and activeflag = 1;
   
     update assessment_history 
set
    activeflag = 0,
    updatedby = 'CJAMS-67716',
    updatedon = now ()
where
    assessmentid = '7dbf9442-8dd9-4bb0-a4ff-8a15d164ef7a'
    and activeflag = 1;

    ----No record in assessmentsubmission 
   
 update routing
set
    activeflag = 0,
    updatedby = 'CJAMS-67716',
    updatedon = now ()
where
    objectid = '7dbf9442-8dd9-4bb0-a4ff-8a15d164ef7a'
    and activeflag = 1 and  eventcode='ASST';


    

    --3175162
update assessment a
set
    activeflag = 0,
    updatedby = 'CJAMS-67716',
    updatedon = now ()
where
    assessmentid = '73a3767d-dcb8-4fd6-913c-fff77b1b8b90'
    and activeflag = 1;

    -----no record in assessmentactor

      update assessmentcomments 
set
    activeflag = 0,
    updatedby = 'CJAMS-67716',
    updatedon = now ()
where
    assessmentid = '73a3767d-dcb8-4fd6-913c-fff77b1b8b90'
    and activeflag = 1;
   
     update assessment_history 
set
    activeflag = 0,
    updatedby = 'CJAMS-67716',
    updatedon = now ()
where
    assessmentid = '73a3767d-dcb8-4fd6-913c-fff77b1b8b90'
    and activeflag = 1;

    ----No record in assessmentsubmission 
   
 update routing
set
    activeflag = 0,
    updatedby = 'CJAMS-67716',
    updatedon = now ()
where
    objectid = '73a3767d-dcb8-4fd6-913c-fff77b1b8b90'
    and activeflag = 1 and  eventcode='ASST';