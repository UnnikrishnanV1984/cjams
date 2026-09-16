/*
   Issue Description: CJAMS-60404
   Category/ Module  : Case Closure & IVE-Dashboard
   Root cause: User requested to remove ive-review request 
   Pull request# for code fix: 
   Reason why no related code fix:  User error.
   
*/

update ivecaseclosurereview set activeflag = 0, updatedon = now(), updatedby = 'CJAMS-60404'
where ivecaseclosurereviewid = '448a396e-5887-48bf-8e89-68166f0756c7' and activeflag = 1;

update routing set activeflag = 0, updatedon = now(), updatedby = 'CJAMS-60404'
where objectid= '448a396e-5887-48bf-8e89-68166f0756c7' and activeflag = 1;