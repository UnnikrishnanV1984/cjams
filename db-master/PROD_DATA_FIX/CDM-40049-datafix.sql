/*
   Issue Description: CDM-40049
   Category/ Module  : Education
   Root cause:user requested to add enrollment tab for child Mykhell Smith
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update personeducation set enrollmentdate='2023-08-23 00:00:00',updatedby='CDM-40049',updatedon=now()
where personeducationid='53d28e94-d3b8-4570-bfc0-2b2954635433' and personid='ff235985-e4e8-4509-9722-72a588b4db0c';