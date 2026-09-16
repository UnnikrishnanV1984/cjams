/*
  Issue Description: CDM-26296
   Category/ Module  :  221030016050:In the safe-C OHP section on the assessments page it lists the placement as Michael Beall for the last two safe-c OHP's that were completed. This is the worker and not the placement resource.
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   data fix issue, 
   Backup before update/ delete:
*/


update assessment 
set submissiondata = replace(submissiondata::text, '"placementlivingarrangement": "Michael Beall"' , '"placementlivingarrangement": "Mary Ice"')::json
where objectid = 'b6b512dd-a7ad-4749-a2b6-d7f2bbcb0230' and submissionid='63616b454ced3f001b14fdca';


update assessment 
set submissiondata = replace(submissiondata::text, '"placementlivingarrangement": "Michael Beall"' , '"placementlivingarrangement": "Mary Ice"')::json
where objectid = 'b6b512dd-a7ad-4749-a2b6-d7f2bbcb0230' and submissionid='63616af54ced3f001b14fdc9';
