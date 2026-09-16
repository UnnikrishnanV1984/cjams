/*
  Issue Description: CDM-18413 - Program Manage is unable to access Service Records: Teneille Wilson
   Category/ Module  :  staff management
   Root cause: User added wrong role.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: old id - roleid =151
*/

update rolemapping set roleid=36, updatedby='CDM-18413', updatedon=now() where principalid in (7065,7700,14082)
and teamtypekey='CW' and activeflag=1
and id in (61637834,61649836,60317614);