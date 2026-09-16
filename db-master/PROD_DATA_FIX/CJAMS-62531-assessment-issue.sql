/*
Issue: CJAMS-62531 SAFE-C OHP is under Review status but the section 3 - Safety Influences questions are blank while its all mandatory.
       Case ID: 3200756
       Client ID: 3430125 (Marcus Gray)
Category/Module: Assessment
Root cause:  Submission id is blank for the safe-c ohp assessment due to which we are unable to view records in the safe-c assessment that are sent for supervisor approval
             We tried to replicate this issue in stage environment and it is not reproducible.
             During the analysis we have found like there are total 8 cases having no submission id records and we need to do a bulk data fix as a part of other ticket.
             Root cause will be analysed as the part of another CDM ticket.
Fix provided: Data fix to insert submissionid information for the assement table in the case for the case
              Case ID: 3200756
              Client ID: 3430125 (Marcus Gray)
Data/Code fix ticket#: CJAMS-62531
Regression Impacts: N/A
Is Code fix Required?: TBD
Code fix ticket#: N/A
Reason why no related code fix: We are still analysing this issue and will try to replicate it in stage environment.The latest insertion happened on 10-08-2025.
                                No latest records were found after the current release and we open a code fix once it is replicable.
*/

-- Case ID: 3200756
-- Client ID: 3430125 (Marcus Gray)

update assessment
set submissionid = gen_random_uuid(),
    updatedby = 'CJAMS-62531'
where assessmentid='6cfa2ae9-48c3-4984-8fe7-22c73449ca49'
and activeflag = 1;