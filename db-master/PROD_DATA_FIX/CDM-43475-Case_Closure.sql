/*
   Issue Description: CDM-43475
   Category/ Module  : Case Closure & IVE-Dashboard
   Root cause: User requested to remove ive-review request 
   Pull request# for code fix: 
   Reason why no related code fix:  User error.
   
*/

update ivecaseclosurereview set activeflag = 0, updatedon = now(), updatedby = 'CDM-43475'
where objectid = '84332130-403b-46a2-bb8c-8ce20adafe13' and activeflag = 1;

update routing set activeflag = 0, updatedon = now(), updatedby = 'CDM-43475'
where objectid= 'f29a80ac-84c4-46bd-86af-0be9c00e57f6' and activeflag = 1;