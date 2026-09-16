/*
  Issue Description:  CDM-41643
   Category/ Module  : Approval
   Root cause: User request to connect the service case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

select * from cjams.createservicecase('5be57ed0-0a15-46fc-8a56-bc42d35c0782', '', 1, '9d8fc15e-a94c-4e42-b9b8-4b71a9dc8976'::character varying,'ASSGN','CDM-41643');