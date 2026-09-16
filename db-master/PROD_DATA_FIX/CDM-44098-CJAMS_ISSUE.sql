/* 
    Issue Description: CDM-44098
   Category/ Module  : Hospitalization
   Root cause: User requested delete duplicate hospitalization record
   Pull request# for code fix: 
   Reason why no related code fix: User Error
*/


update personhospitalization
set activeflag = 0, updatedon = now(), updatedby ='CDM-44098'
where personid ='613589ac-f736-46ef-a0f2-c1b3f066f46d' and hospitalizationid ='127503ae-3606-46de-afed-8a511d22a1ef';