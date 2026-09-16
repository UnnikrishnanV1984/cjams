 /*
   Issue Description: CIDM-10805 Psychotropic Secondary Review Rollout 11/10/2025
   Category/ Module  :  Psychotrophic Secondary Review
   Root cause: Phase 4 county rollout
   Fix provided : Enabled config for phase 4 county setups
   Code fix ticket#: NA
   Reason why no related code fix: NA
   Status of the code fix if already submitted and expected prod fix date:  NA
   Backup before update/ delete: NA
*/
update  cjams.countygoliveconfig
set 
annearundel ='2025-11-10' ,
baltimorecounty ='2025-11-10',
harford='2025-11-10',
updatedby='CIDM-10805',
updatedon=now()
where objecttype in ('psycotrophic-secondary-review','psycotrophic-hcdm');