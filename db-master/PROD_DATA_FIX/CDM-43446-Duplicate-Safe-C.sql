/*
   Issue Description: CDM-43446
   Category/ Module  : Assessments Safce c 
   Root cause: Needed to delete safeC assessment.
   Reason why no related code fix: 
    requested a data fix and code fix to resolve
*/


update assessment 
set activeflag = 0, updatedon = now(),updatedby = 'CDM-43446'
where assessmentid = '4a5e3bdd-8b41-4e9c-8531-9c716b26412c' and activeflag = 1;

update assessmentactor 
set activeflag = 0, updatedon = now(),updatedby = 'CDM-43446'
where assessmentactorid='4865a9b2-aaea-457c-ad79-17875c88cb38' and activeflag = 1;

update assessment_history 
set activeflag = 0, updatedon = now(),updatedby = 'CDM-43446'
where assessmentid = '4a5e3bdd-8b41-4e9c-8531-9c716b26412c' and activeflag = 1;

update assessmentcomments 
set activeflag = 0, updatedon = now(),updatedby = 'CDM-43446'
where assessmentid = '4a5e3bdd-8b41-4e9c-8531-9c716b26412c' and activeflag = 1;


update routing 
set activeflag = 0, updatedon = now(),updatedby = 'CDM-43446'
where objectid = '4a5e3bdd-8b41-4e9c-8531-9c716b26412c' and activeflag = 1;