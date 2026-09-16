/*
   Issue Description: CDM-42016
   Category/ Module  : Assessments
   Root cause: User requested to change the dates from 09/20/2024 to 09/19/2024.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
---SAFE-C = 09/19/2024
/*select 	submissiondata, * from assessment
where 	assessmentid = 'c1123b6b-e166-4db2-9a7a-5594363c5953';
objectid = 'c20b1617-c18e-446b-b575-45038d0032ed' 
*/

update 	assessment
set 	submissiondata = jsonb_set(submissiondata, '{dateassessmentinitiated}', '"2024-09-19T18:38:00.000Z"')
--, updatedon = now(), updatedby = 'CDM-42016'
where 	assessmentid  = 'c1123b6b-e166-4db2-9a7a-5594363c5953' and activeflag = 1;

update 	assessment
set 	submissiondata = jsonb_set(submissiondata, '{safetyassessmentcompletiondate}', '"2024-09-19T18:38:00.000Z"')
		--, updatedby = 'CDM-42016', updatedon = now()
where 	assessmentid  = 'c1123b6b-e166-4db2-9a7a-5594363c5953' and activeflag = 1;
