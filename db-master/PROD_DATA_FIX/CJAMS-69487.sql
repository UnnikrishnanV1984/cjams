/*
  Issue Description: CJAMS-69487- Child placement was end dated incorrectly and child removal end date
                     never transferred from placement
  Category/ Module : Child Removal/Placement
  Root cause: The last placement was exited as 'Change in Placement Structure' (CIPS) instead of
              'Permanently Leaving Custody & Care' (PLCC). Only a PLCC exit closes the episode, so the
              placement end date never transferred to the child removal exit date or the OOH program
              assignment end date, and the case was closed leaving both open. The removal was also
              re-opened earlier by datafix CJAMS-68860, which cleared these same end dates.
  Fix provided : Data fix has been done to update the following for Case# 251030508710,
                 Client ID 201901022 (Mariana Fluelling) as requested by the user
                  1. Out of Home Program Assignment End Date - 06/24/2026
                  2. Placement Exit Type - Permanently Leaving Custody and Care
                  3. Child Removal End Date - 06/24/2026
  Regression Impacts: N/A
  Is Code fix needed: No
  Reason why no related code fix: Incorrect placement exit type selected by the user, data fix should resolve it.
*/


-- 1. Out of Home Program Assignment End Date should be 06/24/2026
UPDATE cjams.personprogramarea
	SET enddate = '2026-06-24 00:00:00',
		updatedby = 'CJAMS-69487',
		updatedon = now()
WHERE personprogramid = 'b5e7d1c2-08c1-433a-83a0-1026ed5d2bf2'
	AND personid = 'f6dc0535-acf1-4cc0-8542-c61da9deae97'
	AND programkey = 'OOH'
	AND objectid = 'd89b9782-95c0-4f56-893c-e0f1bebb7643'
	AND activeflag = 1 ;

-- 2. Placement Exit Type should be Permanently Leaving Custody and Care
UPDATE cjams.placement
	SET exittypekey = 'PLCC',	-- Permanently Leaving Custody & Care
		updatedby = 'CJAMS-69487',
		updatedon = now()
WHERE placementid = '59ed1df3-f8cb-4339-8651-76cf7d3e11ed'
	AND intakeservreqchildremovalid = 'db1e9991-e002-4167-a861-72c4d62e6136'
	AND activeflag = 1 ;

-- 3. Child Removal End Date should be 06/24/2026
UPDATE cjams.intakeservreqchildremoval
	SET exitdate = '2026-06-24 00:00:00',
		updatedby = 'CJAMS-69487',
		updatedon = now()
WHERE intakeservreqchildremovalid = 'db1e9991-e002-4167-a861-72c4d62e6136'
	AND servicecaseid = 'd89b9782-95c0-4f56-893c-e0f1bebb7643'
	AND activeflag = 1 ;

-- 4. Client Eligibility End Date should be 06/24/2026
UPDATE cjams.tb_client_eligibility
	SET end_dt = '2026-06-24',
		update_user_id = 'CJAMS-69487',
		update_ts = now()
WHERE eligibility_id = 10190922
	AND removal_id = '387395'
	AND client_id = 201901022
	AND delete_sw = 'N' ;

-- 5. Child Removal history entry for the end date applied by this data fix
INSERT INTO cjams.intakeservreqchildremoval_history(
	intakeservreqchildremovalhistoryid,
	rowtype,
	intakeservreqchildremovalid,
	intakeserviceid,
	activeflag,
	insertedby,
	insertedon,
	updatedby,
	updatedon,
	exitdate,
	removalexitreason,
	intakeservicerequestactorid,
	servicecaseid,
	personid,
	modifieddata)
VALUES (
	gen_random_uuid(),
	'HISTORY',
	'db1e9991-e002-4167-a861-72c4d62e6136',
	NULL,
	'1',
	'CJAMS-69487',
	now(),
	'CJAMS-69487',
	now(),
	'2026-06-24 00:00:00',
	NULL,
	'2fba6fc8-2541-4945-934e-3f130d41bf6c',
	'd89b9782-95c0-4f56-893c-e0f1bebb7643',
	'f6dc0535-acf1-4cc0-8542-c61da9deae97',
	'{"status": "Updated", "data": [ {"key": "comments","data_type": "text", "new_value": "The child removal end date was updated with the datafix ticket CJAMS-69487.","display_name": "Comments"}]}');
