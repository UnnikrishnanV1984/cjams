/*
  Issue Description:  CDM-40144
   Category/ Module  :  Assessments: SAFE-C
   Root cause:Data fix to update the SAFE-C Date Time Assessment Initiated from 07/06/2024 1PM to 07/05/2024 1PM.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

update 	assessment
set submissiondata = jsonb_set(submissiondata, '{dateassessmentinitiated}', '"2024-07-05T17:00:00.000Z"'), updatedby = '72ea08ae-678a-423d-ae3a-44921d219c5e'
		--, updatedon = now()
where objectid = '3d7ba642-54b7-4c58-aefa-3b1fe616c100' and assessmentid = '40ef3caa-57e1-4248-af39-57f9b7b78707' and activeflag = 1;