/*

   Issue Description: CDM-39827-Delete rejected placement

   Category/ Module  : Person

   Root cause: User requested to remove Rejected placement

   Fix provided :Datafix to delete rejected placement

   Code fix ticket#:

   Reason why no related code fix: 

   Status of the code fix if already submitted and expected prod fix date: 

   Backup before update/ delete:

*/

update placement set activeflag = 0, updatedon = now(), updatedby = 'CDM-39827' where placementid in ('847fc221-4916-474f-ba36-84fd6d0c0cb2','55185903-e010-40f2-870f-2059a6ca5f57');


update placementrevision set  activeflag = 0, updatedon = now(), updatedby = 'CDM-39827' where placementid in ('847fc221-4916-474f-ba36-84fd6d0c0cb2','55185903-e010-40f2-870f-2059a6ca5f57');

update livingarrangement set  activeflag = 0, updatedon = now(), updatedby = 'CDM-39827' where placementid in ('847fc221-4916-474f-ba36-84fd6d0c0cb2','55185903-e010-40f2-870f-2059a6ca5f57');

update routing  set  activeflag = 0, updatedon = now(), updatedby = 'CDM-39827' where objectid in ('847fc221-4916-474f-ba36-84fd6d0c0cb2','55185903-e010-40f2-870f-2059a6ca5f57') and activeflag =1;

