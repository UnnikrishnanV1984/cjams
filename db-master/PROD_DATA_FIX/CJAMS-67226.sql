
/*
   Issue Description: CJAMS-67226
   Category/ Module  :PADS is unable to be reviewed and approved by Supervisor
   Root cause: Code fix is done aspart of CDM-44815, but user wants to approve the form ,so proceeding with a datafix to approve the pads assessment form 
   Fix provided: Datafix is done to approve the pads assessment form 
   Is cide fix reqired: Y-CDM-44815
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
-- WE ARE NOT UPDATING AUDIT COLUMNS SINCE UPDATEDBY NAME IS MISSING
UPDATE assessment
SET submissiondata = jsonb_set(
                        jsonb_set(
                            submissiondata::jsonb,
                            '{assessmentStaus}', 
                            '"Accepted"'
                        ),
                        '{authorizationForm,assessmentstatus}', 
                        '"Accepted"'
                     )
                     
WHERE submissionid = '9e312f0f-22a4-4769-ad92-77efd259d75e'
  AND assessmentid = '0231824c-709f-4270-a895-26b7c4686583'
  AND activeflag = 1;
 
update assessment 
set assessmentstatustypekey='Accepted'
where assessmentid='0231824c-709f-4270-a895-26b7c4686583' and activeflag=1;