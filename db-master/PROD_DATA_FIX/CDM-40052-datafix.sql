/*
   Issue Description: CDM-40052
   Category/ Module  : Education
   Root cause:user requested to add enrollment tab for PID: 4369597
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update personeducation set enrollmentdate='2023-08-23 00:00:00',updatedby='CDM-40052',updatedon=now()
where personeducationid='21671d9b-2872-41e2-8f06-1be26972d57c' and personid='e69611b8-8df5-4e86-9f07-645c1d87fa71';