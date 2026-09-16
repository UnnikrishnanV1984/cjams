/*
   Issue Description: CIDM-10807 Psychotropic Secondary Review Rollout 03/30/2026
   Category/ Module  :  Psychotrophic Secondary Review
   Root cause: Phase 6 county (Baltimore City) rollout
   Fix provided : Enabled config for phase 5 county setups
   Code fix ticket#: NA
   Reason why no related code fix: NA
   Status of the code fix if already submitted and expected prod fix date:  NA
   Backup before update/ delete: NA
*/
UPDATE  cjams.countygoliveconfig
	SET baltimorecity = '2026-03-30',
		updatedby = 'CIDM-10807',
		updatedon = now()
	WHERE objecttype IN ('psycotrophic-secondary-review','psycotrophic-hcdm');