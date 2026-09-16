/*
   Issue Description: CDM-29768
   Category/ Module  : Child Removal 
   Root cause: Soft deleting the removal record and send for approval
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update routing 
set activeflag = 0, updatedon = now(), updatedby = 'CDM-29768'
where objectid in ('a8bb46e1-0559-467d-b51d-5864bd9ad2b6', '9094bb0f-aac6-4aeb-a67d-6077b760f04e','4c3e93f5-1870-420d-a4b6-1f1693f51e6b');

update intakeservreqchildremoval 
set activeflag = 0, updatedon = now(), updatedby = 'CDM-29768'
where intakeservreqchildremovalid in ('a8bb46e1-0559-467d-b51d-5864bd9ad2b6','9094bb0f-aac6-4aeb-a67d-6077b760f04e','4c3e93f5-1870-420d-a4b6-1f1693f51e6b');