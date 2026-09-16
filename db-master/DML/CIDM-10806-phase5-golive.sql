 /*
   Issue Description: CIDM-10806 Psychotropic Secondary Review Rollout 01/12/2026
   Category/ Module  :  Psychotrophic Secondary Review
   Root cause: Phase 5 county (Prince George & Howard) rollout
   Fix provided : Enabled config for phase 5 county setups
   Code fix ticket#: NA
   Reason why no related code fix: NA
   Status of the code fix if already submitted and expected prod fix date:  NA
   Backup before update/ delete: NA
*/
UPDATE  cjams.countygoliveconfig
	SET princegeorges = '2026-01-12' ,
		howard = '2026-01-12',
		updatedby = 'CIDM-10806',
		updatedon = now()
	WHERE objecttype IN ('psycotrophic-secondary-review','psycotrophic-hcdm');