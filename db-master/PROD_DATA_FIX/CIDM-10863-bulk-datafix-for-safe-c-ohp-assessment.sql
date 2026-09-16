/*
Issue:CIDM-10863 SAFE-C OHP assessment review data are not shown
Category/Module: Safe-c OHP
Root cause: There are some safe-c ohp records created and sent for supervisor review without any submission id creation in the DB.
            Due to this we are unable to view those records for approval by supervisor.We are trying to replicate this issue in stage env
            but it is not reproducible.
Fix provided:Bulk Data fix is done to add submissionid for all the approved safe-c ohp records which are missing it.
            Case numbers with assessments to be updated are 3128907
                                                            231030211088
                                                            221030015948
                                                            3200756
                                                            221030018898
                                                            202105606210
Data/Code fix ticket#: CIDM-10863
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This issue is not replicable after the latest major release and we will track for similar issues.
*/

--We are not updating the audit column updated on as it will impact the assessment record displayed in the assessment page.

--case number 3128907
update assessment
set submissionid = gen_random_uuid(),
    updatedby = 'CJAMS-62531'
where assessmentid='7e36a55f-a071-4d42-bfd1-0f2e1e46e02d'
and activeflag = 1;

--case number 231030211088
update assessment
set submissionid = gen_random_uuid(),
    updatedby = 'CJAMS-62531'
where assessmentid='96541f2b-0949-4999-9bc4-f4576d2f4172'
and activeflag = 1;

--case number 221030015948
update assessment
set submissionid = gen_random_uuid(),
    updatedby = 'CJAMS-62531'
where assessmentid='1be32cfd-b39c-46de-b24b-258b7e888b0b'
and activeflag = 1;

--case number 3200756
update assessment
set submissionid = gen_random_uuid(),
    updatedby = 'CJAMS-62531'
where assessmentid='6cfa2ae9-48c3-4984-8fe7-22c73449ca49'
and activeflag = 1;

--case number 221030018898
update assessment
set submissionid = gen_random_uuid(),
    updatedby = 'CJAMS-62531'
where assessmentid='84aed34b-25f9-4763-9a62-a667013c9ccc'
and activeflag = 1;

--case number 202105606210
update assessment
set submissionid = gen_random_uuid(),
    updatedby = 'CJAMS-62531'
where assessmentid='4c1afe91-7f10-4c53-a0fd-4ac90daade48'
and activeflag = 1;