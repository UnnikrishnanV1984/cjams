 /*
   Issue Description: CIDM-10687 Psychotropic Secondary Review Phase 2 rollout
   Category/ Module  :  Psychotrophic Secondary Review
   Root cause: Phase 2 county rollout
   Fix provided : Enabled config for phase 2 county setups - Aug 04
   Code fix ticket#: NA
   Reason why no related code fix: NA
   Status of the code fix if already submitted and expected prod fix date:  NA
   Backup before update/ delete: NA
*/
update  cjams.countygoliveconfig
set stmarys='2025-08-04',
charles='2025-08-04',
calvert='2025-08-04',
cecil='2025-08-04',
kent='2025-08-04',
queenannes='2025-08-04',
talbot='2025-08-04',
caroline='2025-08-04',
dorchester='2025-08-04',
wicomico='2025-08-04',
somerset='2025-08-04',
worcester='2025-08-04',
updatedby='CIDM-10687',
updatedon=now()
where objecttype in ('psycotrophic-secondary-review','psycotrophic-hcdm');