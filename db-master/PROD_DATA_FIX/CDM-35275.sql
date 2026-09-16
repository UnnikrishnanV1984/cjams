/*
 * CDM-35275 - AFCARS
 * Customer Email ID:erika.ehrhardt@maryland.gov
 * Customer Name:Erika L. Ehrhardt
 * Focus Area:Persons: Others
 * Existing Condition box to be checked
 * Case # 3269828
 * PID # 3271807 (KODY ZANE DUVALL)
 * 
 */

--select existingcondition , * from persondisability where persondisabilityid = 'd01402f9-b9de-45eb-930c-88624f372dca';
UPDATE cjams.persondisability
SET existingcondition=true, updatedby='CDM-35275', updatedon=now() 
WHERE persondisabilityid='d01402f9-b9de-45eb-930c-88624f372dca'::uuid;
