/* 
 Issue Description: CIDM-10806 Psychotropic Secondary Review Rollout 01/12/2026
   Category/ Module  :  Psychotrophic Secondary Review
   Root cause: Phase 5 county (Prince George & Howard) rollout
				Prince George's county column spelling need to be corrected 
   Fix provided : Enabled config for phase 5 county setups & corrected princegeorges column name
   Code fix ticket#: NA
   Reason why no related code fix: NA
   Status of the code fix if already submitted and expected prod fix date:  NA
   Backup before update/ delete: NA
*/


ALTER TABLE cjams.countygoliveconfig RENAME COLUMN princegeorge TO princegeorges;