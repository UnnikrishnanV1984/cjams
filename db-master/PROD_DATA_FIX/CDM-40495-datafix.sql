/*
  Issue Description:  CDM-40495
   Category/ Module  :  Application
   Root cause: Removed blank program assignments
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/
---Client ID: 3509013
UPDATE cjams.personprogramarea
set activeflag = 0 where 
personprogramid in ('d1d95658-a1ef-4d34-8ede-efac00b69198','74f1631a-ca10-410a-a5de-cb5eb9c11ce1','61f20cef-9ba7-4c64-97d0-ab1e5f7f240e') and activeflag = 1;

----Client ID: 3438429
UPDATE cjams.personprogramarea
set activeflag = 0 where 
personprogramid in ('a8ba9bdd-8dd1-4b69-95b7-22365922386d','a3d50ee0-a053-41f8-8d9a-77ad31eeb805') and activeflag = 1;
