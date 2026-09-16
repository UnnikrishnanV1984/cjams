/*
 * CIDM-8108 - End date the Child Removal - CDM-34850
 * Need data fix to end date the child removal with the same date
 * Case # 231030092912
 * CJAMS PID# : 4378868
 * CJAMS Id/Referral Id:Case # 231030092912
 * Focus Area:Child Removal
*/

select exitdate, * from intakeservreqchildremoval where intakeservreqchildremovalid = '6ebf27c7-577f-47be-8b88-e016b4f82cd0';
UPDATE cjams.intakeservreqchildremoval
SET exitdate='2023-06-27 13:35:00.000', removalexitreason='REUNIF', updatedby = 'CIDM-8108', updatedon  = now() 
WHERE intakeservreqchildremovalid='6ebf27c7-577f-47be-8b88-e016b4f82cd0'::uuid;

select enddate, * from personprogramarea where personprogramid = '1529b57e-af78-4adb-97bf-d8b85c22ceb1';
UPDATE cjams.personprogramarea
SET enddate='2023-06-27 13:35:00.000', updatedby = 'CIDM-8108', updatedon  = now() 
WHERE personprogramid='1529b57e-af78-4adb-97bf-d8b85c22ceb1'::uuid
