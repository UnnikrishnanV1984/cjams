/*
   Issue Description: CDM-15055
   Category/ Module  : Assessments
   Root cause: User requested to change the dates and updatedBy from Brenda Carr to Alison Lillis
   Pull request# for code fix: 
   Reason why no related code fix:  code fix is already done
   Status of the code fix if already submitted and expected prod fix date: 
*/

-- here the issue issue time when we are updating with this format it can update correctly but if we are updating this format we need to change data becuase that might be IST time ('"2021-07-04T03:30:00.000Z"' this one equal to '"2021-07-03T23:30"' )

update 	assessment
set 	submissiondata = jsonb_set(submissiondata, '{dateoflastsafetyplan}', '"2021-07-03T23:30"'), updatedby ='CDM-15055', updatedon = now()
where submissionid ='754d0320-9732-4940-b20c-c1aa8a3911b7' and assessmentid ='5238d701-5f99-4daa-99f0-ffcb79ae82f3';
