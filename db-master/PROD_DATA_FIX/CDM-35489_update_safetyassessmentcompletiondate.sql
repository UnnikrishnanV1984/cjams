/*
   Issue Description: CDM-35489 - SEN SAFE-C report incorrect
   Category/ Module  : Case / Assessment
   Root cause: User requested to update the safety assessment completion date time
   Fix Privided: Data fix
*/
update  cjams.assessment set submissiondata = jsonb_set(submissiondata:: jsonb, '{safetyassessmentcompletiondate}', '"2023-10-05T09:30"')
where assessmentid =  'd517cd60-c4e8-4fa3-915e-34010151ec45';