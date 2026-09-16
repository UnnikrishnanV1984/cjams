 /*
   Issue Description: CIDM-10804 Psychotropic Secondary Review Rollout 09/25/2025
   Category/ Module  :  Psychotrophic Secondary Review
   Root cause: Phase 3 county rollout
   Fix provided : Enabled config for phase 3 county setups
   Code fix ticket#: NA
   Reason why no related code fix: NA
   Status of the code fix if already submitted and expected prod fix date:  NA
   Backup before update/ delete: NA
*/
update  cjams.countygoliveconfig
set 
carroll ='2025-09-25' ,
montgomery ='2025-09-25',
updatedby='CIDM-10804',
updatedon=now()
where objecttype in ('psycotrophic-secondary-review','psycotrophic-hcdm');