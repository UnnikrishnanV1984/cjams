/* 
    Issue Description: CJAMS-58375
   Category/ Module  : Child removal 
   Root cause: User requested add child removal end date which was missing due to invalid manual placement added though (CDM-44106)
   Pull request# for code fix: 
   Reason why no related code fix: Invalid data fix (CDM-44106)
*/

update  cjams.assessment set submissiondata = jsonb_set(submissiondata:: jsonb, '{datetimefield1}', '"2025-03-17T13:00:00.000Z"'),
updatedby ='CJAMS-58429', updatedon = now()
where assessmentid =  '8f763903-89dc-4aa8-aed5-b585f0195a0a';